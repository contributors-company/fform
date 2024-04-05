import 'package:fform/fform.dart';

class DescriptionField extends FFormField<String?, String> {
  DescriptionField.dirty({required String value}) : super(value);

  @override
  String? validator(value) {
    return null;
  }
}
