import 'package:fform/fform.dart';

enum PasswordConfirmFieldException {
  different;

  @override
  String toString() {
    switch(this) {
      case different: return 'PasswordConfirmField not different';
    }
  }
}

class PasswordConfirmField extends FFormField<String, PasswordConfirmFieldException> {
  final String password;

  const PasswordConfirmField.pure(this.password) : super.pure('');
  PasswordConfirmField.dirty(super.value, this.password) : super.dirty();

  @override
  PasswordConfirmFieldException? validator(String value) {
    if(password != value) {
      return PasswordConfirmFieldException.different;
    } else {
      return null;
    }
  }
}