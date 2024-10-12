import 'package:fform/fform.dart';

import './forms/default_form.dart';

void main(List<String> arguments) async {
  final form = DefaultForm();

  form.title.addListener(printResponse);

  final printDefaultForm = printForm(form);

  form.addListener(printDefaultForm);
  printTitle(form.title);

  form.title.value = 'He';

  form.title.value = 'Hello';

  printTitle(form.title);

  await Future.delayed(Duration(seconds: 2), () {});

  form.title.value = 'He';

  await Future.delayed(Duration(seconds: 2), () {});

  form.title.value = 'Hello';

  printTitle(form.title);
  await Future.delayed(Duration(seconds: 2), () {});

  form.removeListener(printDefaultForm);
  form.title.removeListener(printResponse);
}

void printTitle(FFormField title) {
  print(
      'Title: ${title.value}, Exception: ${title.exception != null ? title.exception.toString() : 'null'}');
}

void printResponse(FFormFieldResponse response) {
  print(
      'Response: ${response.value}, Exception: ${response.exception != null ? response.exception.toString() : 'null'}');
}

void Function() printForm(FForm form) => () {
      print('Form: ${form.fields}');
    };

/*
RESULT:

Title: , Exception: titleEmpty
Response: He, Exception: titleMinLength
Response: Hello, Exception: null
Title: Hello, Exception: null
Response: Hello, Exception: asyncError
Response: Hello, Exception: asyncError
Response: Hello, Exception: asyncError
Response: He, Exception: titleMinLength
Response: He, Exception: titleMinLength
Response: Hello, Exception: asyncError
Title: Hello, Exception: null
Response: Hello, Exception: asyncError

Process finished with exit code 0

 */
