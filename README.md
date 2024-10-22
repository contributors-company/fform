# FForm Package 🚀

![Pub Version](https://img.shields.io/pub/v/fform)
![Build Status](https://img.shields.io/github/actions/workflow/status/AlexHCJP/fform/build.yml)
![License](https://img.shields.io/github/license/AlexHCJP/fform)
![Issues](https://img.shields.io/github/issues/AlexHCJP/fform)

- [Introduction](#getting-started-with-fform-)
  - [Getting Started with FForm 🌟](#getting-started-with-fform-)
  - [Step 1: Installation](#step-1-installation)
  - [Overview](#overview)
  - [Why It Rocks 🎸](#why-it-rocks-)
- [Usage Example](#usage-examples)
  - [`FFormField`](#fformfield)
    - [Example](#example)
    - [`KeyedField`](#and-you-can-add-keyedfield-mixin-to-get-a-unique-key-for-identifying-the-form-field-widget)
    - [`AsyncField`](#and-you-can-use-asyncvalidator)
  - [`FForm`](#fform)
    - [Example](#example-1)
  - [`FFormBuilder`](#fformbuilder)
    - [Example](#example-2)
  - [`FFormProvider`](#fformprovider)
    - [Example](#example-3)
  - [`FFormException`](#fformexception)
    - [Example](#example-4)



# Getting Started with FForm 🌟

## Step 1: Installation

First things first, let's get the FForm package into your Flutter project. Add FForm to your `pubspec.yaml` file under dependencies:

```yaml
dependencies:
  fform: ^latest_version
```

Don't forget to run `flutter pub get` in your terminal to install the package.

## Overview

FForm is a high-level Flutter package designed to make form creation and management a breeze, with simplified field validation. It offers two main components: `FFormField` and `FFormBuilder`, that together bring ease and flexibility to your form handling in Flutter apps.

- `FFormField<T, E>`: A base class for all form fields supporting values, on-the-fly validation, and change handling.
- `FFormBuilder<F extends FForm>`: A widget that constructs and manages the form state, utilizing streams to refresh the UI dynamically as data changes.
- `FForm`: A base class for creating custom form classes, allowing you to add specific methods and properties to your forms.
- `FFormException`: A base class for creating custom exceptions for form fields, enabling you to define custom validation rules and error messages.
- `FFormProvider`: A widget that allows you to access the form in the widget tree without passing it as a parameter.
- `KeyedField`: A mixin that provides a unique key for identifying the form field widget, used to manage the state of the widget and access it in the widget tree.
- `AsyncField`: A mixin that provides asynchronous validation for form fields, allowing you to validate data against external sources or APIs.

## Why It Rocks 🎸

- **State Management Simplified**: Automatically handles the state of both individual form fields and the form as a whole.
- **Built-in Validation with a Twist**: Supports on-the-fly validation and error handling for each field, ensuring a smooth user experience.
- **Flexibility at Its Finest**: Supports any data type for field values and validation errors thanks to generics.
- **Reactive Forms for the Win**: Leverages streams for tracking form state changes, ensuring your UI is always in sync.
- **Multiple Forms, No Problem**: Create multiple forms with custom fields and validation rules, all managed seamlessly by FForm.
- **Custom Exceptions for Custom Needs**: Define custom exceptions for form fields to handle complex validation rules and error messages with ease.
- **AsyncValidator**: Supports asynchronous validation for form fields, allowing you to validate data against external sources or APIs.


## Previews

|                                                              |                                                              |                                                              |
|--------------------------------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| ![](https://github.com/AlexHCJP/fform/raw/main/pictures/1.gif) | ![](https://github.com/AlexHCJP/fform/raw/main/pictures/2.gif) | ![](https://github.com/AlexHCJP/fform/raw/main/pictures/3.gif) |
| ![](https://github.com/AlexHCJP/fform/raw/main/pictures/4.gif) |                                                              |                                                              |


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

#### And you can add KeyedField mixin to get a unique key for identifying the form field widget.

```dart
class EmailField extends FFormField<String, EmailError> with KeyedField {

  EmailField({required String value}) : super(value);

  @override
  EmailError? validator(value) {
    if (value.isEmpty) return EmailError.empty;
    return null;
  }
}

// and get GlobalKey -> form.email.key 
```

#### And you can use AsyncValidator

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

### `FForm`

`FForm` is a base class for creating custom form classes with specific fields and validation rules. It provides a set of getters and methods to manage the form state, including checking the form's validity, retrieving answers, and handling exceptions.

#### Example

This is a simple example of how to create a form with a single field. You can extend the `FForm` class to create custom forms with specific fields and validation rules.

```dart
class LoginForm extends FForm {
  EmailField email;
  
  LoginForm({
    required this.email,
  }): super(fields: [email]);
}
```

This is a more complex example of how to create a form with multiple fields. You can extend the `FForm` class to create custom forms with specific fields and validation rules.

```dart
class Form extends FForm {
  List<Form> forms;

  Form({
    required this.forms,
  }): super(subForms: forms);
}
```


### `FFormBuilder`

`FFormBuilder` is a widget that constructs and manages the form state, utilizing streams to refresh the UI dynamically as data changes. It provides a builder function that takes the form and returns a widget tree based on the form's state.

#### Example

This is an example of how to use `FFormBuilder` to create a form with a single field. The builder function takes the form as a parameter and returns a widget tree based on the form's state.

```dart
void _submit() {
  if(_form.check()) { // .isValid or .isInvalid start rebuild in FFormBuilder and returned boolean
    print('Form Valid');
  };
}

@override
Widget build(BuildContext context) {
  return FFormBuilder<LoginForm>(
    form: _form,
    builder: (context, form) {
      EmailField email = form.email; // or FFormProvider.of<LoginForm>(context).get<NameField>()
      
      return Column(
        children: [
          TextField(
            key: email.key,
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: email.exception.toString(),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

```

You can use `ListenableBuilder` to rebuild only the field that has changed,
but you can use `FFormProvider` to rebuild all fields in the form.

```dart
void _submit() {
  if(_form.check()) { // .isValid or .isInvalid start rebuild in FFormBuilder and returned boolean
    print('Form Valid');
  };
}

@override
Widget build(BuildContext context) {
  return ListenableBuilder<LoginForm>(
    listenable: _form,
    builder: (context, form) {
      EmailField email = form.email; // or FFormProvider.of<LoginForm>(context).get<NameField>()
      
      return Column(
        children: [
          TextField(
            key: email.key,
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: email.exception.toString(),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}
```

---

### `FFormProvider`

`FFormProvider` is a widget that allows you to access the form in the widget tree without passing it as a parameter.

#### Example

```dart
FFormBuilder<LoginForm>(
  form: _form,
  builder: (context, form) {
    
    FFormProvider.of<LoginForm>(context).email; // or form.email;
    FFormProvider.of<LoginForm>(context).get<NameField>(); // or form.get<NameField>();

    return YourForm();
  },
)
```

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

## Examples

- [Login Form](./example/lib/screens/login_screen.dart)
- [Add Forms to Multiple Form](./example/lib/screens/create_quest_screen.dart)
- [Infinity Forms](./example/lib/screens/multi_screen.dart)
- [Hard Custom Field](./example/lib/screens/exception_multi_screen.dart)


## How to Contribute

1. Fork the repository
2. Clone the repository
3. Create a new branch
4. Make your changes
5. Commit your changes
6. Push to the branch
7. Submit a pull request
8. Wait for approval
9. Happy coding!