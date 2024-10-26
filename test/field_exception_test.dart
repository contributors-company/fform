import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

class MyException extends FFormException {
  MyException({required this.message, this.isValid = false});

  final String message;
  @override
  final bool isValid;

  @override
  String toString() => 'MyException: $message';
}

class MyFormField extends FFormField<String, MyException> {
  MyFormField(String value) : super(value);

  @override
  MyException? validator(String value) {
    if (value.isEmpty) {
      return MyException(message: 'Value cannot be empty');
    }

    return MyException(message: 'Value contains warning', isValid: true);
  }
}

void main() {
  group('FFormException Tests', () {
    test('Field with valid value should be valid', () async {
      final field = MyFormField('Valid Value');
      final isValid = await field.check();
      expect(isValid, isTrue);
      expect(field.isValid, isTrue);
      expect(field.isInvalid, isFalse);
      expect(field.exception, isNull);
    });

    test('Field with invalid value should be invalid', () async {
      final field = MyFormField('');
      final isValid = await field.check();
      expect(isValid, isFalse);
      expect(field.isValid, isFalse);
      expect(field.isInvalid, isTrue);
      expect(field.exception, isNotNull);
      expect(field.exception, isA<MyException>());
      expect(field.exception?.message, 'Value cannot be empty');
    });

    test('Updating value should trigger validation', () async {
      final field = MyFormField('');
      await field.check();
      expect(field.isValid, isFalse);

      field.value = 'New Valid Value';
      await field.check();
      expect(field.isValid, isTrue);
      expect(field.exception, isNull);
    });

    test('Listeners should be notified on exception change', () async {
      final field = MyFormField('');
      var notified = false;
      field.addListener(() {
        notified = true;
      });

      await field.check();
      expect(notified, isTrue);
    });

    test('Exception with isValid true should be considered valid', () async {
      final field = MyFormField('Value with warning');
      final isValid = await field.check();
      expect(isValid, isTrue);
      expect(field.isValid, isTrue);
      expect(field.exception,
          isNull); // Так как isValid = true, exception сбрасывается
    });

    test('Exception with isValid false should be considered invalid', () async {
      final field = MyFormField('');
      final isValid = await field.check();
      expect(isValid, isFalse);
      expect(field.isValid, isFalse);
      expect(field.exception, isNotNull);
      expect(field.exception, isA<MyException>());
      expect(field.exception?.message, 'Value cannot be empty');
    });
  });
}
