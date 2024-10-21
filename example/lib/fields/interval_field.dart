import 'package:fform/fform.dart';

class IntervalField extends FFormField<String?, String> {
  IntervalField.dirty({required String value}) : super(value);

  @override
  String? validator(value) {
    return null;
  }
}
