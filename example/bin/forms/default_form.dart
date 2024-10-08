import 'package:fform/fform.dart';
import '../fields/title_field.dart';

class DefaultForm extends FForm {
  final TitleField title = TitleField();

  @override
  List<FFormField> get fields => [title];
}
