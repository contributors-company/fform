import 'package:fform/fform.dart';

enum PasswordConfirmFieldException {
  different;

  @override
  String toString() {
    switch (this) {
      case different:
        return 'PasswordConfirmField not different';
    }
  }
}

class PasswordConfirmField
    extends FFormField<String, PasswordConfirmFieldException> {
  String password;

  PasswordConfirmField(super.value, this.password);

  @override
  PasswordConfirmFieldException? validator(String value) {
    if (password != value) return PasswordConfirmFieldException.different;
    return null;
  }
}
