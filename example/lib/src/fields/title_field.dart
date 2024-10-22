import 'package:fform/fform.dart';

enum TitleError {
  empty,
  min;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'titleEmpty';
      case min:
        return 'titleMin';
      default:
        return 'invalidFormatTitle';
    }
  }
}

class TitleField extends FFormField<String, TitleError> with KeyedField {
  bool isRequired;

  TitleField.dirty({
    required String value,
    this.isRequired = true,
  }) : super(value);

  @override
  TitleError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return TitleError.empty;
      if (value.length < 8) return TitleError.min;
    }
    return null;
  }
}
