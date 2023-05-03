import 'package:example_fform/fields/name_field.dart';
import 'package:example_fform/fields/password_confirm_field.dart';
import 'package:example_fform/fields/password_field.dart';
import 'package:fform/fform.dart';

class LoginForm extends FForm {
  final NameField name;
  final PasswordField password;
  final PasswordConfirmField passwordConfirm;

  LoginForm(
      {this.name = const NameField.pure(),
      this.password = const PasswordField.pure(),
      this.passwordConfirm = const PasswordConfirmField.pure('')});

  LoginForm copyWith(
      {NameField? name,
      PasswordField? password,
      PasswordConfirmField? passwordConfirm}) {
    return LoginForm(
        name: name ?? this.name,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm);
  }

  @override
  List<FFormField> get fields => [name, password, passwordConfirm];
}
