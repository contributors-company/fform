import 'package:fform/fform.dart';

enum EmailError {
  empty,
  not,
  email;

  @override
  String toString() {
    switch (this) {
      case empty:
        return 'emailEmpty';
      case not:
        return 'invalidFormatEmail';
      default:
        return 'invalidFormatEmail';
    }
  }
}

class EmailField extends FFormField<String, EmailError>
    with  AsyncField<String, EmailError>, CacheField<String, EmailError> {
  EmailField({required String value}) : super(value);

  @override
  EmailError? validator(value) {
    if (value.isEmpty) return EmailError.empty;
    return null;
  }

  @override
  Future<EmailError?> asyncValidator(value) async =>
      await Future.delayed(const Duration(seconds: 1), () {
        if (value == 'alexganbert@gmail.com') return null;
        return EmailError.email;
      });
}
