import 'package:fform/fform.dart';

enum DescriptionFieldError { empty }

class DescriptionField extends FFormField<String, DescriptionFieldError> {
  DescriptionField({required String value}) : super(value);

  @override
  DescriptionFieldError? validator(value) {
    if (value.isEmpty) return DescriptionFieldError.empty;
    return null;
  }
}
