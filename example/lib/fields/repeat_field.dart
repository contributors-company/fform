import 'package:fform/fform.dart';

enum RepeatError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'repeatEmpty';
      default:
        return 'invalidFormatRepeat';
    }
  }
}

class RepeatField extends FFormField<int?, RepeatError> {
  bool isRequired;

  RepeatField.dirty({
    required int? value,
    this.isRequired = false,
  }) : super(value);

  @override
  RepeatError? validator(value) {
    if (isRequired) {
      if (value == null) return RepeatError.empty;
    }
    return null;
  }
}
