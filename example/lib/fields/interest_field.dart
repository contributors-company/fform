import 'package:fform/fform.dart';

import '../models/models.dart';

enum InterestError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'interestEmpty';
      default:
        return 'invalidFormatInterest';
    }
  }
}

class InterestField extends FFormField<List<InterestModel>, InterestError> {
  bool isRequired;

  InterestField.dirty({
    required List<InterestModel> value,
    this.isRequired = false,
  }) : super(value);

  @override
  InterestError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return InterestError.empty;
    }
    return null;
  }
}
