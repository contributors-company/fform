import 'package:fform/fform.dart';

import '../models/models.dart';

enum ChildrenError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'childrenEmpty';
      default:
        return 'invalidFormatChildren';
    }
  }
}

class ChildrenField extends FFormField<Children?, ChildrenError> {
  bool isRequired;

  ChildrenField.dirty({
    required Children? value,
    this.isRequired = false,
  }) : super(value);

  @override
  ChildrenError? validator(value) {
    if (isRequired) {
      if (value == null) return ChildrenError.empty;
    }
    return null;
  }
}
