import 'package:example_fform/fields/name_field.dart';
import 'package:example_fform/fields/password_confirm_field.dart';
import 'package:example_fform/fields/password_field.dart';
import 'package:fform/fform.dart';

class LoginForm extends FForm {
  NameField name;
  PasswordField password;
  PasswordConfirmField passwordConfirm;

  LoginForm({
    this.name = const NameField.pure(),
    this.password = const PasswordField.pure(),
    this.passwordConfirm = const PasswordConfirmField.pure(''),
  });

  void changeFields({
    NameField? name,
    PasswordField? password,
    PasswordConfirmField? passwordConfirm,
  }) {
    this.name = name ?? this.name;
    this.password = password ?? this.password;
    this.passwordConfirm = passwordConfirm ?? this.passwordConfirm;
    set(this);
  }

  @override
  List<FFormField> get fields => [name, password, passwordConfirm];
}
