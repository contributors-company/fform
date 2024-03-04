import 'package:fform/fform.dart';

enum PasswordFieldException {
  min;

  @override
  String toString() {
    switch (this) {
      case min:
        return 'PasswordField.min.8';
    }
  }
}

class PasswordField extends FFormField<String, PasswordFieldException> {
  PasswordField(super.value);

  @override
  PasswordFieldException? validator(String value) {
    if (value.length <= 7) {
      return PasswordFieldException.min;
    } else {
      return null;
    }
  }
}
