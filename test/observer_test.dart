import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

class MyFForm extends FForm {
  MyFForm() : super(fields: []);
}

class MyFormObserver extends FFormObserver {
  bool wasChecked = false;
  bool? formIsValid;

  @override
  void check(FForm form) {
    wasChecked = true;
    formIsValid = form.isValid;
  }
}

class ValidateField extends FFormField<String, FFormException> {
  ValidateField(String value) : super(value);

  @override
  FFormException? validator(String value) => null;
}

class InvalideField extends FFormField<String, FieldException> {
  InvalideField(String value) : super(value);

  @override
  FieldException? validator(String value) => FieldException();
}

class FieldException extends FFormException {
  @override
  bool get isValid => false;
}

void main() {
  group('FFormObserver Tests', () {
    late MyFormObserver observer;
    setUp(() {
      observer = MyFormObserver();
      FForm.observer = observer;
    });

    test('Observer should detect when form is valid', () {
      MyFForm().check();

      expect(observer.wasChecked, isTrue);
      expect(observer.formIsValid, isTrue);
    });

    test('Observer should detect when form is invalid', () {
      MyFForm()
        ..addField(InvalideField(''))
        ..check();

      expect(observer.wasChecked, isTrue);
      expect(observer.formIsValid, isFalse);
    });

    test('Observer should not be checked before check is called', () {
      final observer = MyFormObserver();

      expect(observer.wasChecked, isFalse);
      expect(observer.formIsValid, isNull);
    });

    test('Observer should not be checked before check is called', () {
      final observer = MyFormObserver()..check(MyFForm());

      expect(observer.wasChecked, isTrue);
      expect(observer.formIsValid, isTrue);
    });
  });
}
