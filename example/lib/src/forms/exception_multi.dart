import 'package:fform/fform.dart';

import '../fields/exception_mullti/password_field.dart';

class ExceptionMultiForm extends FForm {
  PasswordField password = PasswordField('');

  @override
  List<FFormField> get fields => [password];
}
