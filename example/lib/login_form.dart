import 'package:example_fform/fields/name_field.dart';
import 'package:example_fform/fields/password_confirm_field.dart';
import 'package:example_fform/fields/password_field.dart';
import 'package:fform/fform.dart';

class LoginForm extends FForm {
  NameField name;
  PasswordField password;
  PasswordConfirmField passwordConfirm;

  LoginForm({
    String? name,
    String? password,
    String? passwordConfirm,
  })  : name = NameField(name ?? ''),
        password = PasswordField(password ?? ''),
        passwordConfirm = PasswordConfirmField(
          passwordConfirm ?? '',
          password ?? '',
        );

  void changeFields({
    String? name,
    String? password,
    String? passwordConfirm,
  }) {
    this.name.value = name ?? this.name.value;
    this.password.value = password ?? this.password.value;
    this.passwordConfirm.password = password ?? this.passwordConfirm.password;
    this.passwordConfirm.value = passwordConfirm ?? this.passwordConfirm.value;
  }

  @override
  List<FFormField> get fields => [name, password, passwordConfirm];

  @override
  bool get allFieldUpdateCheck => true;
}
