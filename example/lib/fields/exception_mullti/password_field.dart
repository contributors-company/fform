import 'package:fform/fform.dart';
import 'package:fform_validator/fform_validator.dart';

class PasswordValidationException extends FFormException {
  final bool isMinLengthValid;
  final bool isSpecialCharValid;
  final bool isNumberValid;

  PasswordValidationException({
    required this.isMinLengthValid,
    required this.isSpecialCharValid,
    required this.isNumberValid,
  });

  @override
  bool get isValid => isMinLengthValid && isSpecialCharValid && isNumberValid;
}

class PasswordField extends FFormField<String, PasswordValidationException> {
  PasswordField(String value) : super(value);

  @override
  PasswordValidationException? validator(String value) {
    final validator = FFormValidator(value);
    return PasswordValidationException(
      isMinLengthValid: validator.isMinLength(8),
      isSpecialCharValid: validator.isHaveSpecialChar,
      isNumberValid: validator.isHaveNumber,
    );
  }
}
