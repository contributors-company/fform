import 'package:fform/fform.dart';

enum CountError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      ///Todo count users
      case empty:
        return 'countEmpty';
      default:
        return 'invalidFormatCount';
    }
  }
}

///Todo rename CountField to repeat
class CountField extends FFormField<int?, CountError> {
  bool isRequired;

  CountField.dirty({
    required int? value,
    this.isRequired = true,
  }) : super(value);

  @override
  CountError? validator(value) {
    if (isRequired) {
      if (value == null) return CountError.empty;
    }
    return null;
  }
}
