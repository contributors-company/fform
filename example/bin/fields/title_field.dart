import 'package:fform/fform.dart';

enum TitleException {
  empty,
  minLength;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'titleEmpty';
      case minLength:
        return 'titleMinLength';
      default:
        return 'invalidFormatTitle';
    }
  }
}

class TitleField extends FFormField<String, TitleException> {
  TitleField({String? value}) : super(value ?? '');

  @override
  TitleException? validator(String value) {
    if (value.isEmpty) return TitleException.empty;
    if (value.length < 3) return TitleException.minLength;
    return null;
  }
}
