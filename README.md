# FForm Package 🚀

![Pub Version](https://img.shields.io/pub/v/fform)
![Build Status](https://img.shields.io/github/actions/workflow/status/AlexHCJP/fform/build.yml)
![License](https://img.shields.io/github/license/AlexHCJP/fform)
![Issues](https://img.shields.io/github/issues/AlexHCJP/fform)


---

- [Introduction](#getting-started-with-fform-)
  - [Getting Started with FForm 🌟](#getting-started-with-fform-)
  - [Step 1: Installation](#step-1-installation)
  - [Overview](#overview)
  - [Why It Rocks 🎸](#why-it-rocks-)
- [Usage Example](#usage-examples)
  - [`FFormField`](#fformfield)
    - [Example](#example)
    - [And you can use AsyncValidator](#and-you-can-use-asyncvalidator)
    - [`FFormField` API](#fformfield-api)
  - [`FForm`](#fform)
    - [Example](#example-1)
    - [`FForm` API](#fform-api)
  - [`FFormException`](#fformexception)
    - [Example](#example-2)
    - [`FFormException` API](#fformexception-api)
  


# Getting Started with FForm 🌟

## Step 1: Installation

First things first, let's get the FForm package into your Dart project. Add FForm to your `pubspec.yaml` file under dependencies:

```yaml
dependencies:
  fform: ^latest_version
```

## If you are using Flutter, you will also need to add the [`fform_flutter`](https://pub.dev/packages/fform_flutter) package:
```yaml
dependencies:
  fform: ^latest_version
  fform_flutter: ^latest_version
```

Don't forget to run `flutter pub get` in your terminal to install the package.

---

## Overview

FForm is a high-level Dart package designed to make form creation and management a breeze, with simplified field validation. 

- `FFormField<T, E>`: A base class for all form fields supporting values, on-the-fly validation, and change handling.
- `FForm`: A base class for creating custom form classes, allowing you to add specific methods and properties to your forms.
- `FFormException`: A base class for creating custom exceptions for form fields, enabling you to define custom validation rules and error messages.

## Why It Rocks 🎸

- **State Management Simplified**: Automatically handles the state of both individual form fields and the form as a whole.
- **Built-in Validation with a Twist**: Supports on-the-fly validation and error handling for each field, ensuring a smooth user experience.
- **Flexibility at Its Finest**: Supports any data type for field values and validation errors thanks to generics.
- **Reactive Forms for the Win**: Leverages streams for tracking form state changes, ensuring your UI is always in sync.
- **Multiple Forms, No Problem**: Create multiple forms with custom fields and validation rules, all managed seamlessly by FForm.
- **Custom Exceptions for Custom Needs**: Define custom exceptions for form fields to handle complex validation rules and error messages with ease.
- **AsyncValidator**: Supports asynchronous validation for form fields, allowing you to validate data against external sources or APIs.

## Previews

```dart

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
 */


```



## Usage Examples

### `FFormField`

`FFormField` is a base class for all form fields, supporting values, on-the-fly validation, and change handling. It provides a set of getters and methods to manage the field state, including checking the field's validity, retrieving the current value, and handling exceptions.

#### Example

```dart
enum EmailError {
  empty,
  not;

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

class EmailField extends FFormField<String, EmailError> {

  EmailField({required String value}) : super(value);

  @override
  EmailError? validator(value) {
    if (value.isEmpty) return EmailError.empty;
    return null;
  }
}
```

### And you can use AsyncValidator

```dart
class EmailField extends FFormField<String, EmailError> with AsyncField<String, EmailError> {

  EmailField({required String value}) : super(value);

  @override
  EmailError? validator(value) {
    if (value.isEmpty) return EmailError.empty;
    return null;
  }

  @override
  Future<EmailError?> asyncValidator(value) async {
    await Future.delayed(Duration(seconds: 1));
    if (!value.contains('@')) return EmailError.not;
    return null;
  }
}
```

#### `FFormField` API

| Getters / Setters     | Description                                                                          |
|-----------------------|--------------------------------------------------------------------------------------|
| T get value           | Retrieves the current value of the form field.                                       |
| set value(T newValue) | Sets a new value for the form field and triggers listeners if the value changes.     |
| E? get exception      | Retrieves the current validation exception of the form field, if any.                |
| bool get isValid      | Checks if the form field is valid based on the current value and validation rules.   |
| bool get isInvalid    | Checks if the form field is invalid based on the current value and validation rules. |

| Methods                                                | Description                                                                                     |
|--------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| void addListener(FFormFieldListener<T, E> listener)    | Adds a listener that will be called when the value of the form field changes.                   |
| void removeListener(FFormFieldListener<T, E> listener) | Removes a previously added listener from the form field.                                        |
| E? validator(T value)                                  | Validates the current value of the form field and returns an exception if the value is invalid. |

### `FForm`

`FForm` is a base class for creating custom form classes with specific fields and validation rules. It provides a set of getters and methods to manage the form state, including checking the form's validity, retrieving answers, and handling exceptions.

#### Example

This is a simple example of how to create a form with a single field. You can extend the `FForm` class to create custom forms with specific fields and validation rules.

```dart
class LoginForm extends FForm {
  EmailField email;
  
  LoginForm({
    required this.email,
  });

  @override
  List<FFormField> get fields => [email];
}
```

This is a more complex example of how to create a form with multiple fields. You can extend the `FForm` class to create custom forms with specific fields and validation rules.

```dart
class Form extends FForm {
  List<Form> forms;

  Form({
    required this.forms,
  });

  @override
  List<FFormField> get subForms => forms;
}
```

`allFieldUpdateCheck` is a property in `FForm` that determines whether every field update triggers a rebuild of the `FFormBuilder`. When set to `true`, the form will rebuild on every field update, ensuring real-time feedback to the user. When set to `false`, the form will only rebuild when the `isValid` or `isInvalid` getters are invoked, reducing the number of rebuilds and enhancing performance.

```dart
class LoginForm extends FForm {
  EmailField email;

  LoginForm({
    required this.email,
  });

  @override
  bool get allFieldUpdateCheck => true;
  
  @override
  List<FFormField> get fields => [email];
}
```

#### `FForm` API

| Getters                           | Description                                                                                                                                                                                                   |
|-----------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| bool get hasCheck                 | Returns whether the form has any validation checks. This getter checks if there are any validation rules applied to the form fields.                                                                          |
| bool get allFieldUpdateCheck      | Indicates if every field update triggers a rebuild of the `FFormBuilder`. This is used to determine if the form should be rebuilt on every field update.                                                      |
| List<FFormField> get fields       | Retrieves the list of form fields in the form. This getter is used to access all the fields that are part of the form.                                                                                        |
| List<FForm> get subForms          | Retrieves the list of sub-forms within the form. This is used when the form contains nested forms, allowing access to those sub-forms.                                                                        |
| List<dynamic> get answers         | Retrieves the list of answers from the form fields. This getter collects the current values of all form fields.                                                                                               |
| List<dynamic> get exceptions      | Retrieves the list of validation exceptions from the form fields. This is used to gather all validation errors present in the form fields.                                                                    |
| bool get isValid                  | Checks if the entire form is valid based on the current values and validation rules. This getter evaluates the validity of the form by checking each field's validation status and calls `notifyListeners()`. |
| bool get isInvalid                | Checks if the entire form is invalid based on the current values and validation rules. This is the inverse of `isValid` and is used to quickly determine if the form has any invalid fields.                  |
| FFormField? get firstInvalidField | Retrieves the first invalid form field, if any. This getter is used to find the first field that fails validation.                                                                                            |
| FFormField? get lastInvalidField  | Retrieves the last invalid form field, if any. This getter is used to find the last field that fails validation.                                                                                              |


| Methods                                     | Description                                                                                                                                                                     |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| void addListener(FFormListener listener)    | Adds a listener that will be called when the form's state changes. This is useful for updating the UI or performing actions when the form's state changes.                      |
| void removeListener(FFormListener listener) | Removes a previously added listener from the form. This is useful for cleaning up listeners when they are no longer needed.                                                     |
| void notifyListeners()                      | Notifies all registered listeners of a change in the form's state. This is used to trigger updates in the UI or other parts of the application that depend on the form's state. |
| T get<T extends FFormField>()               | Retrieves the first field of a specific type from the form. This is useful for accessing specific fields without knowing their exact position in the form.                      |


### FFormException

`FFormException` is a base class for creating custom exceptions for form fields. It allows you to define custom validation rules and error messages for form fields, enabling you to handle complex validation scenarios with ease.

#### Example

You can create a custom exception class that extends `FFormException` to define specific validation rules and error messages for a form field.

```dart
class PasswordValidationException extends FFormException {
  final bool isMinLengthValid;
  final bool isSpecialCharValid;
  final bool isNumberValid;

  PasswordValidationException({
    required this.isMinLengthValid,
    required this.isSpecialCharValid,
    required this.isNumberValid,
  });

  @override
  bool get isValid => isMinLengthValid && isSpecialCharValid && isNumberValid;
}

class PasswordField extends FFormField<String, PasswordValidationException> {
  PasswordField(String value) : super(value);

  @override
  PasswordValidationException? validator(String value) {
    final validator = FFormValidator(value);
    return PasswordValidationException(
      isMinLengthValid: validator.isMinLength(8),
      isSpecialCharValid: validator.isHaveSpecialChar,
      isNumberValid: validator.isHaveNumber,
    );
  }
}
```

#### FFormException API

| Getters          | Description                                                                                |
|------------------|--------------------------------------------------------------------------------------------|
| bool get isValid | Returns `true` if the form field is valid based on the current value and validation rules. |

