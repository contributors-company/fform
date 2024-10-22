import 'package:fform/fform.dart';

import '../fields/email_field.dart';
import '../fields/password_field.dart';

class LoginForm extends FForm {
  final EmailField email;
  final PasswordField password;

  LoginForm({
    required this.email,
    required this.password,
  }) : super(fields: [email, password]);

  factory LoginForm.zero() {
    return LoginForm(
      email: EmailField(value: ''),
      password: PasswordField(value: ''),
    );
  }

  void change({
    required String email,
    required String password,
  }) {
    this.email.value = email;
    this.password.value = password;
  }
}
