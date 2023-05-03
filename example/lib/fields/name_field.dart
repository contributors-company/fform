import 'package:fform/fform.dart';

enum NameFieldException {
  min;

  @override
  String toString() {
    switch (this) {
      case min:
        return 'NameField.min.3';
    }
  }
}

class NameField extends FFormField<String, NameFieldException> {
  const NameField.pure() : super.pure('');
  NameField.dirty(super.value) : super.dirty();

  @override
  NameFieldException? validator(String value) {
    if (value.length <= 2) {
      return NameFieldException.min;
    } else {
      return null;
    }
  }
}
