import 'package:fform/fform.dart';

import '../models/age.dart';

enum AgeError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'ageEmpty';
      default:
        return 'invalidFormatAge';
    }
  }
}

class AgeField extends FFormField<AgeModel?, AgeError> {
  bool isRequired;

  AgeField.dirty({
    required AgeModel? value,
    this.isRequired = false,
  }) : super(value);

  @override
  AgeError? validator(value) {
    if (isRequired) {
      if (value == null) return AgeError.empty;
    }
    return null;
  }
}
