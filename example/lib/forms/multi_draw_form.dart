import 'package:fform/fform.dart';

import 'forms.dart';

class MultiDrawForm extends FForm {
  final DrawForm drawForm;
  final List<MultiDrawForm> drawForms;

  MultiDrawForm({required this.drawForm, required this.drawForms});

  @override
  List<FFormField> get fields => [];

  @override
  List<FForm> get subForms => [drawForm, ...drawForms];
}
