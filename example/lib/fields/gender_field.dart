import 'package:fform/fform.dart';

import '../models/models.dart';

enum GenderError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'genderEmpty';
      default:
        return 'invalidFormatGender';
    }
  }
}

/// Todo use enum Gender
class GenderField extends FFormField<Gender?, GenderError> {
  bool isRequired;

  GenderField.dirty({
    required Gender? value,
    this.isRequired = false,
  }) : super(value);

  @override
  GenderError? validator(value) {
    if (isRequired) {
      if (value == null) return GenderError.empty;
    }
    return null;
  }
}
