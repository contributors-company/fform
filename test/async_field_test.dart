import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

class MyAsyncFormField extends FFormField<String, String>
    with AsyncField<String, String> {
  MyAsyncFormField(String value) : super(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Value cannot be empty';
    }
    return null;
  }

  @override
  Future<String?> asyncValidator(String value) async =>
      await Future.delayed(const Duration(milliseconds: 100), () {
        if (value == 'invalid') {
          return 'Async validation failed';
        }
        return null;
      });
}

void main() {
  group('AsyncField Tests', () {
    test('Valid value passes both sync and async validation', () async {
      final field = MyAsyncFormField('Valid Value');
      final isValid = await field.check();
      expect(isValid, isTrue);
      expect(field.isValid, isTrue);
      expect(field.exception, isNull);
    });

    test('Empty value fails sync validation', () async {
      final field = MyAsyncFormField('');
      final isValid = await field.check();
      expect(isValid, isFalse);
      expect(field.isValid, isFalse);
      expect(field.exception, isNotNull);
      expect(field.exception, 'Value cannot be empty');
    });

    test('"invalid" value fails async validation', () async {
      final field = MyAsyncFormField('invalid');
      final isValid = await field.check();
      expect(isValid, isFalse);
      expect(field.isValid, isFalse);
      expect(field.exception, isNotNull);
      expect(field.exception, 'Async validation failed');
    });

    test('Value changes trigger revalidation', () async {
      final field = MyAsyncFormField('');
      await field.check();
      expect(field.isValid, isFalse);

      field.value = 'invalid';
      await field.check();
      expect(field.isValid, isFalse);
      expect(field.exception, 'Async validation failed');

      field.value = 'Valid Value';
      await field.check();
      expect(field.isValid, isTrue);
      expect(field.exception, isNull);
    });

    test('Listeners are notified on exception change', () async {
      final field = MyAsyncFormField('invalid');
      var notified = false;
      field.addListener(() {
        notified = true;
      });

      await field.check();
      expect(notified, isTrue);
    });
  });
}
