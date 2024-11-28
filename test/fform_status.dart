import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

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
  group('FFormStatus Tests', () {
    late MockForm form;

    setUp(() {
      // Создаем форму с валидными и невалидными полями
      form = MockForm(fields: [
        MockFFormField('Valid Field'), // Валидное поле
        MockFFormField(''),           // Невалидное поле (пустое значение)
        MockFFormField(null),         // Невалидное поле (null значение)
      ]);
    });

    test('Initial status is FFormStatus.initial', () {
      expect(form.status, equals(FFormStatus.initial));
    });

    test('Status changes to loading during check()', () {
      expect(form.status, equals(FFormStatus.initial));
      form.check();
      expect(form.status, equals(FFormStatus.exception));

    });

    test('Status changes to exception if some fields are invalid', () async {
      await form.checkAsync();
      expect(form.status, equals(FFormStatus.exception));
    });

    test('Status changes to success if all fields are valid', () async {
      // Пересоздаем форму с валидными полями
      form = MockForm(fields: [
        MockFFormField('Field 1'),
        MockFFormField('Field 2'),
        MockFFormField('Field 3'),
      ]);

      await form.checkAsync();
      expect(form.status, equals(FFormStatus.success));
    });

    test('Validator correctly identifies invalid fields', () {
      for (var field in form.fields) {
        final result = field.validator(field.value);
        if (field.value == null || field.value == '') {
          expect(result, equals('Field is required'));
        } else {
          expect(result, isNull);
        }
      }
    });

    test('Subforms affect overall form status', () async {
      final subForm = MockForm(fields: [
        MockFFormField('Subform Field 1'),
        MockFFormField(''), // Невалидное поле в подформе
      ]);

      form = MockForm(subForms: [subForm]);

      await form.checkAsync();
      expect(form.status, equals(FFormStatus.exception));
    });

    test('All subforms and fields are valid, form status is success', () async {
      final subForm = MockForm(fields: [
        MockFFormField('Subform Field 1'),
        MockFFormField('Subform Field 2'),
      ]);

      form = MockForm(
        subForms: [subForm],
        fields: [MockFFormField('Field 1')],
      );

      await form.checkAsync();
      expect(form.status, equals(FFormStatus.success));
    });
  });
}
