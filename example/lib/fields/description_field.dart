import 'package:fform/fform.dart';

class DescriptionField extends FFormField<String?, String> with KeyedField {
  DescriptionField.dirty({required String value}) : super(value);

  @override
  String? validator(value) {
    return null;
  }
}
