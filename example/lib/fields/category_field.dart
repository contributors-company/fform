import 'package:fform/fform.dart';

import '../models/models.dart';

enum CategoryError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'categoryEmpty';
      default:
        return 'invalidFormatCategory';
    }
  }
}

class CategoryField extends FFormField<CategoryModel?, CategoryError> {
  bool isRequired;

  CategoryField.dirty({
    required CategoryModel? value,
    this.isRequired = true,
  }) : super(value);

  @override
  CategoryError? validator(value) {
    if (isRequired) {
      if (value == null) return CategoryError.empty;
    }
    return null;
  }
}
