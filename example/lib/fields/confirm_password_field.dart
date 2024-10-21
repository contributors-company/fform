import 'package:fform/fform.dart';

enum ConfirmPasswordError {
  empty,
  doesNotMatch;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'repeatPasswordEmpty';
      case doesNotMatch:
        return 'repeatPasswordDontLikePassword';
      default:
        return 'repeatPasswordDontLikePassword';
    }
  }
}

class ConfirmPasswordField extends FFormField<String, ConfirmPasswordError> {
  String password;
  final bool isRequired;

  ConfirmPasswordField({
    required String value,
    required this.password,
    this.isRequired = true,
  }) : super(value);

  @override
  ConfirmPasswordError? validator(String value) {
    if (isRequired) {
      if (value.isEmpty) {
        return ConfirmPasswordError.empty;
      } else if (value != password) {
        return ConfirmPasswordError.doesNotMatch;
      }
    }
    return null;
  }
}
