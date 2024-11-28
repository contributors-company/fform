import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock classes for testing
class MockFFormField extends FFormField<Object?, String> {
  MockFFormField(super.value);

  @override
  String? validator(Object? value) {
    if (value == null || (value is String && value.isEmpty)) {
      return 'Field is required';
    }
    return null;
  }
}

class MockForm extends FForm {
  MockForm({List<FForm>? subForms, List<FFormField<Object?, Object?>>? fields})
      : super(subForms: subForms ?? [], fields: fields ?? []);
}

void main() {
  group('FForm Tests', () {
    test('Initial state of the form is valid when no fields are provided', () {
      final form = MockForm();
      expect(form.isValid, true);
      expect(form.isInvalid, false);
    });

    test('Form becomes invalid when a field with an error is added', () {
      final form = MockForm();
      final invalidField = MockFFormField('');

      form.addField(invalidField);

      expect(form.isValid, false);
      expect(form.firstInvalidField, invalidField);
    });

    test('Form becomes valid when the invalid field is fixed', () {
      final form = MockForm();
      final invalidField = MockFFormField('');

      form.addField(invalidField);
      expect(form.isValid, false);

      invalidField.value = 'Valid input';
      form.check();

      expect(form.isValid, true);
    });

    test('Async validation works and form becomes valid after corrections',
        () async {
      final form = MockForm();
      final invalidField = MockFFormField('');

      form.addField(invalidField);

      expect(await form.checkAsync(), false); // Initial validation fails

      invalidField.value = 'Corrected value';
      expect(
          await form.checkAsync(), true); // After correction, validation passes
    });

    test(
        'Form correctly tracks multiple fields with different validation states',
        () {
      final form = MockForm();
      final validField = MockFFormField('Valid value');
      final invalidField = MockFFormField('');

      form
        ..addField(validField)
        ..addField(invalidField);

      expect(form.isValid, false);
      expect(form.firstInvalidField, invalidField);

      invalidField.value = 'Fixed value';
      form.check();
      expect(form.isValid, true);
    });

    test('Subforms are correctly integrated into the validation flow',
        () async {
      final subForm = MockForm();
      final form = MockForm()..addSubForm(subForm);
      final fieldInSubForm = MockFFormField(null); // Invalid field

      subForm.addField(fieldInSubForm);

      expect(form.isValid, false);
      expect(await form.checkAsync(), false); // Entire form is invalid due to subform

      fieldInSubForm.value = 'Valid input';
      expect(
          await form.checkAsync(), true); // Now both form and subform are valid
    });

    test('Adding and removing fields dynamically works correctly', () {
      final form = MockForm();
      final field = MockFFormField('Valid');

      form.addField(field);
      expect(form.isValid, true);

      form.removeField(field);
      expect(form.isValid, true); // Form still valid after field removal
    });

    test('First and last invalid fields are tracked correctly', () {
      final form = MockForm();
      final firstInvalidField = MockFFormField('');
      final lastInvalidField = MockFFormField('');

      form
        ..addField(firstInvalidField)
        ..addField(lastInvalidField);

      expect(form.firstInvalidField, firstInvalidField);
      expect(form.lastInvalidField, lastInvalidField);

      // Correct the first field, now only last field should be invalid
      firstInvalidField.value = 'Valid';
      form.check();

      expect(form.firstInvalidField, lastInvalidField);
      expect(form.lastInvalidField, lastInvalidField);
    });

    test('Form resets correctly after all fields are fixed', () async {
      final form = MockForm();
      final invalidField1 = MockFFormField('');
      final invalidField2 = MockFFormField('');

      form
        ..addField(invalidField1)
        ..addField(invalidField2);

      expect(await form.checkAsync(), false);

      invalidField1.value = 'Valid 1';
      invalidField2.value = 'Valid 2';
      expect(await form.checkAsync(), true); // Now both fields are valid
    });

    test('Exception list is updated correctly when fields become invalid', () {
      final form = MockForm();
      final invalidField1 = MockFFormField(null);
      final invalidField2 = MockFFormField('');

      form
        ..addField(invalidField1)
        ..addField(invalidField2);

      expect(form.exceptions.length, 2); // Two invalid fields
      expect(form.exceptionFields.length, 2); // Two invalid fields
      expect(form.exceptionSubForms.length, 0); // Two invalid fields

      invalidField1.value = 'Fixed';
      form.check();

      expect(form.exceptions.length, 1); // Now only one field is invalid
    });

    test('Form works correctly with multiple nested subforms', () async {
      final subForm1 = MockForm();
      final subForm2 = MockForm();
      final form = MockForm()
        ..addSubForm(subForm1)
        ..addSubForm(subForm2);

      final fieldInSubForm1 = MockFFormField('Valid');
      final fieldInSubForm2 = MockFFormField(''); // Invalid field

      subForm1.addField(fieldInSubForm1);
      subForm2.addField(fieldInSubForm2);

      expect(await form.checkAsync(), false); // SubForm 2 is invalid

      fieldInSubForm2.value = 'Valid';
      expect(await form.checkAsync(), true);
      // Now all subforms and fields are valid
    });

    test('Form works correctly with multiple nested subforms', () async {
      final subForm1 = MockForm();
      final subForm2 = MockForm();
      final form = MockForm()
        ..addSubForm(subForm1)
        ..addSubForm(subForm2);

      final fieldInSubForm1 = MockFFormField('Valid');
      final fieldInSubForm2 = MockFFormField(''); // Invalid field

      subForm1.addField(fieldInSubForm1);
      subForm2.addField(fieldInSubForm2);

      expect(await form.checkAsync(), false); // SubForm 2 is invalid

      fieldInSubForm2.value = 'Valid';
      expect(await form.checkAsync(), true);

      subForm1.removeField(fieldInSubForm1);
      form.removeSubForm(subForm2);
      expect(await form.checkAsync(), true);
      form.dispose();
    });

    test('FForm Constructor', () async {
      final field = MockFFormField('Valid');
      final subForm = MockForm(fields: [field]);
      final form = MockForm(fields: [field], subForms: [subForm]);

      expect(form.hasCheck, false);
      expect(form.isValid, true);
      expect(form.get<MockFFormField>(), field);

      form.removeField(field);
      expect(form.fields.length, 0);

      expect(form.hasCheck, false);
      expect(form.isValid, true); // Form still valid after field removal
      expect(await form.checkAsync(), true);
      expect(form.hasCheck, true);
      expect(form.subForms.length, 1);
      form.removeSubForm(subForm);
      expect(form.subForms.length, 0);
    });

    test('FForm Dispose', () async {
      MockForm(fields: [MockFFormField('Valid')], subForms: [MockForm()])
          .dispose();
    });
  });
}
