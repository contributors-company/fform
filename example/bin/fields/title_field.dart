import 'package:fform/fform.dart';

enum TitleException {
  empty,
  minLength,
  asyncError;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'titleEmpty';
      case minLength:
        return 'titleMinLength';
      default:
        return 'asyncError';
    }
  }
}

class TitleField extends FFormField<String, TitleException>
    with AsyncField<String, TitleException> {
  TitleField({String? value}) : super(value ?? '');

  @override
  TitleException? validator(String value) {
    if (value.isEmpty) return TitleException.empty;
    if (value.length < 3) return TitleException.minLength;
    return null;
  }

  @override
  Future<TitleException?> asyncValidator() async {
    await Future.delayed(Duration(seconds: 1));
    return TitleException.asyncError;
  }
}
