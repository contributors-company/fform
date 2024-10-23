import 'package:fform/fform.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock exception class to simulate different validation states
class MockException implements FFormException {
  MockException({required this.isValid});

  @override
  final bool isValid;
}

/// Custom field that extends FFormField for testing
class TestFFormField extends FFormField<int, MockException> {
  TestFFormField(super.value);

  @override
  MockException? validator(int value) {
    if (value < 0) {
      return MockException(isValid: false);
    }
    return null;
  }
}

void main() {
  group('FFormField Tests', () {
    test('Initial value should be valid with no exception', () {
      final field = TestFFormField(10);

      expect(field.isValid, true);
      expect(field.exception, isNull);
    });

    test('Validator should detect invalid values and set exception', () {
      final field = TestFFormField(-1);

      expect(field.isValid, false);
      expect(field.exception, isNotNull);
      expect(field.exception!.isValid, false);
    });

    test('Setting exception manually should update field state', () {
      final field = TestFFormField(10)..exception = MockException(isValid: false);

      expect(field.isValid, false);
      expect(field.exception!.isValid, false);
    });

    test('Checking if invalid field becomes valid after value change', () {
      final field = TestFFormField(-5);

      expect(field.isValid, false);

      // Update the value and check validation
      field
        ..value = 10
        ..check();

      expect(field.isValid, true);
      expect(field.exception, isNull);
    });

    test('AsyncField should be handled properly in check()', () async {
      // Mock AsyncField for testing async validation
      final field = TestAsyncField(10);

      expect(await field.check(), true);
      field.value = -1;
      expect(await field.check(), false);
    });
  });
}

/// Mock AsyncField for async validation testing
class TestAsyncField extends FFormField<int, MockException> {
  TestAsyncField(super.value);

  @override
  MockException? validator(int value) {
    if (value < 0) return MockException(isValid: false);
    return null;
  }

  Future<MockException?> getAsyncException() async => await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          if (value < 0) {
            return MockException(isValid: false);
          }
          return null;
        },
      );
}
