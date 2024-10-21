import 'package:fform/fform.dart';

import '../models/models.dart';

enum RegionError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'regionEmpty';
      default:
        return 'invalidFormatRegion';
    }
  }
}

/// Todo use enum List<RegionModel>

class RegionField extends FFormField<List<RegionModel>, RegionError> {
  bool isRequired;

  RegionField.dirty({
    required List<RegionModel> value,
    this.isRequired = false,
  }) : super(value);

  @override
  RegionError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return RegionError.empty;
    }
    return null;
  }
}
