import 'package:fform/fform.dart';

class DescriptionReportField extends FFormField<String?, String> {
  DescriptionReportField.dirty({required String value}) : super(value);

  @override
  String? validator(value) {
    return null;
  }
}
