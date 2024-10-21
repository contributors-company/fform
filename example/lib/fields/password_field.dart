import 'package:fform/fform.dart';

enum PasswordError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'passwordEmpty';
      case min:
        return 'passwordMin';
      default:
        return 'invalidFormatPassword';
    }
  }
}

class PasswordField extends FFormField<String, PasswordError> {
  bool isRequired;

  PasswordField({
    required String value,
    this.isRequired = true,
  }) : super(value);

  @override
  PasswordError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return PasswordError.empty;
      if (value.length < 8) return PasswordError.min;
    }
    return null;
  }
}
