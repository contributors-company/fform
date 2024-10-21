import 'package:example/fields/exception_mullti/password_field.dart';
import 'package:fform/fform.dart';

class ExceptionMultiForm extends FForm {
  PasswordField password = PasswordField('');

  @override
  List<FFormField> get fields => [password];

  @override
  bool get allFieldUpdateCheck => true;
}
