import 'package:fform/fform.dart';

import '../models/models.dart';

enum ActivityError {
  empty;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'activityEmpty';
      default:
        return 'invalidFormatActivity';
    }
  }
}

class ActivityField extends FFormField<List<ActivityModel?>, ActivityError> {
  bool isRequired;

  ActivityField.dirty({
    required List<ActivityModel?> value,
    this.isRequired = false,
  }) : super(value);

  @override
  ActivityError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return ActivityError.empty;
    }
    return null;
  }
}
