# FForm Package 🚀

---

- [Telegram](https://t.me/itskinhead)
- [GitHub](https://github.com/AlexHCJP)

- [Introduction](#getting-started-with-fform-)
  - [Getting Started with FForm 🌟](#getting-started-with-fform-)
  - [Step 1: Installation](#step-1-installation)
  - [Overview](#overview)
  - [Why It Rocks 🎸](#why-it-rocks-)
- [Usage Example](#usage-examples)
  - [Create Default Form](#creating-a-form-field)
    - [Form Field](#creating-a-form-field)
    - [FForm](#extending-fform-with-loginform)
    - [FFormBuilder](#crafting-a-form-with-fformbuilder)
  - [Create Multiple Forms](#creating-multiple-forms)
    - [Multi Form](#creating-multiple-forms)
    - [Check Form in Presentation Layer](#check-form-in-presentation-layer)
  - [Use FFormException for Validation multiple checks](#use-fformexception-for-validation-multiple-checks)
    - [In Presentation Layer](#in-presentation-layer)
    - [Notion](#notion)
- [Important Note 📝](#important-note-)


# Getting Started with FForm 🌟

## Step 1: Installation

First things first, let's get the FForm package into your Flutter project. Add FForm to your `pubspec.yaml` file under dependencies:

```yaml
dependencies:
  fform: ^latest_version
```

Don't forget to run `flutter pub get` in your terminal to install the package.

---

## Overview

FForm is a high-level Flutter package designed to make form creation and management a breeze, with simplified field validation. It offers two main components: `FFormField` and `FFormBuilder`, that together bring ease and flexibility to your form handling in Flutter apps.

- `FFormField<T, E>`: A base class for all form fields supporting values, on-the-fly validation, and change handling.
- `FFormBuilder<F extends FForm>`: A widget that constructs and manages the form state, utilizing streams to refresh the UI dynamically as data changes.
- `FForm`: A base class for creating custom form classes, allowing you to add specific methods and properties to your forms.
- `FFormException`: A base class for creating custom exceptions for form fields, enabling you to define custom validation rules and error messages.

## Why It Rocks 🎸

- **State Management Simplified**: Automatically handles the state of both individual form fields and the form as a whole.
- **Built-in Validation with a Twist**: Supports on-the-fly validation and error handling for each field, ensuring a smooth user experience.
- **Flexibility at Its Finest**: Supports any data type for field values and validation errors thanks to generics.
- **Reactive Forms for the Win**: Leverages streams for tracking form state changes, ensuring your UI is always in sync.
- **Multiple Forms, No Problem**: Create multiple forms with custom fields and validation rules, all managed seamlessly by FForm.
- **Custom Exceptions for Custom Needs**: Define custom exceptions for form fields to handle complex validation rules and error messages with ease.

## Previews

| Login Form                                                   | Add Forms to Multiple Form                                   | Infinity Forms                                               |
|--------------------------------------------------------------|--------------------------------------------------------------|--------------------------------------------------------------|
| ![](https://github.com/AlexHCJP/fform/raw/main/assets/1.gif) | ![](https://github.com/AlexHCJP/fform/raw/main/assets/2.gif) | ![](https://github.com/AlexHCJP/fform/raw/main/assets/3.gif) |
| ![](https://github.com/AlexHCJP/fform/raw/main/assets/4.gif) |                                                              |                                                              |





## Usage Examples

### Creating a Form Field

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
  bool isRequired;

  EmailField({required String value, this.isRequired = true}) : super(value);

  @override
  EmailError? validator(value) {
    if (isRequired) {
      if (value.isEmpty) return EmailError.empty;
    }
    return null;
  }
}
```

### Extending FForm with LoginForm

```dart
class LoginForm extends FForm {
  NameField name;
  
  LoginForm({
    String? name,
  }) : name = NameField(name ?? '');

  void changeFields({
    String? name,
  }) {
    this.name.value = name ?? this.name.value;
  }

  @override
  List<FFormField> get fields => [name];
  
  @override
  bool get allFieldUpdateCheck => true;
}
```

### Crafting a Form with FFormBuilder

```dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final LoginForm _form = LoginForm.zero();

  _checkForm() {
    _form.change(
        email: _emailController.value.text,
        password: _passwordController.value.text);
    return _form.isValid;
  }

  _login() {
    if (_checkForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Row(
            children: [
              Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text('Welcome', style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      );
    } else {
      for (var element in _form.allExceptions) {
        print(element.toString());
      }
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FFormBuilder(
            form: _form,
            builder: (context, form) {
              return Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: form.email.exception.toString(),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: form.password.exception.toString(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

```

### Creating Multiple Forms

```dart
class MultiDrawForm extends FForm {
  final DrawForm drawForm;
  final List<MultiDrawForm> drawForms;

  MultiDrawForm({required this.drawForm, required this.drawForms});

  @override
  List<FFormField> get fields => [];

  @override
  List<FForm> get subForms => [drawForm, ...drawForms];
}

class DrawForm extends FForm {
  TitleField title;
  DescriptionField description;

  DrawForm({
    required this.title,
    required this.description,
  });

  DrawForm.zero() : this(
    title: TitleField.dirty(value: ''),
    description: DescriptionField.dirty(value: ''),
  );

  void changeFields({
    String? title,
    String? description,
  }) {
    this.title.value = title ?? this.title.value;
    this.description.value = description ?? this.description.value;
  }

  @override
  List<FFormField> get fields => [title, description];
}
```

### Check Form in Presentation Layer


```dart

MultiDrawForm builderForm(MultiDrawController controller) {
  return MultiDrawForm(
    drawForm: DrawForm(
      title: TitleField.dirty(
        value: controller.value.drawController.value.title,
      ),
      description: DescriptionField.dirty(
        value: controller.value.drawController.value.description,
      ),
    ),
    drawForms: controller.value.multiDrawControllers.map((e) {
      return builderForm(e);
    }).toList(),
  );
}

class MultiScreen extends StatefulWidget {
  const MultiScreen({super.key});

  @override
  State<MultiScreen> createState() => _MultiScreenState();
}

class _MultiScreenState extends State<MultiScreen> {
  late MultiDrawController _multiDrawController;
  late MultiDrawForm _form;

  @override
  void initState() {
    _multiDrawController = MultiDrawController();
    _form = builderForm(_multiDrawController);
    super.initState();
  }

  @override
  void dispose() {
    _multiDrawController.dispose();
    super.dispose();
  }

  _check() {
    if (_form.isValid) {
      print('Form is valid');
    } else {
      for (var element in _form.allExceptions) {
        print(element.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerApp(),
      appBar: AppBar(
        title: const Text('Draw Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FFormBuilder<MultiDrawForm>(
          form: _form,
          builder: (context, form) {
            return Column(
              children: [
                DrawCard(form: form, controller: _multiDrawController),
                ElevatedButton(
                  onPressed: _check,
                  child: const Text('Check'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DrawCard extends StatefulWidget {
  final MultiDrawForm form;
  final MultiDrawController controller;

  const DrawCard({
    super.key,
    required this.form,
    required this.controller,
  });

  @override
  State<DrawCard> createState() => _DrawCardState();
}

class _DrawCardState extends State<DrawCard> {
  _addDraw() {
    widget.form.drawForms.add(builderForm(widget.controller));
    widget.controller.addDraw();
  }

  _removeDraw(MultiDrawController controller, MultiDrawForm form) => () {
    widget.controller.removeDraw(controller);
    widget.form.drawForms.remove(form);
  };

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 20,
            color: Colors.grey,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.controller,
              builder: (context, value, child) {
                return Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        errorText:
                        widget.form.drawForm.title.exception?.toString(),
                      ),
                      onChanged: (value) {
                        widget.form.drawForm.title.value = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        errorText: widget.form.drawForm.description.exception
                                ?.toString(),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: _addDraw, icon: const Icon(Icons.add)),
                      ],
                    ),
                    ...value.multiDrawControllers.mapWithIndex(
                              (controller, index) {
                        MultiDrawForm form = widget.form.drawForms[index];

                        return Column(
                          children: [
                            DrawCard(
                              controller: controller,
                              form: form,
                            ),
                            IconButton(
                                    onPressed: _removeDraw(controller, form),
                                    icon: const Icon(Icons.remove)),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

```

## Use FFormException for Validation multiple checks

```dart
import 'package:fform/fform.dart';
import 'package:fform_validator/fform_validator.dart';

class PasswordValidationException extends FFormException {
  final bool isMinLengthValid;
  final bool isSpecialCharValid;
  final bool isNumberValid;

  PasswordValidationException({
    required this.isMinLengthValid,
    required this.isSpecialCharValid,
    required this.isNumberValid,
  });
  
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

---

### In Presentation Layer

```dart

void _change() => _form.password.value = _passwordController.text;

bool _showException(bool? isHaveException) {
  if (isHaveException == null) return false;
  return !isHaveException;
}

FFormBuilder(
  form: _form,
  builder: (context, form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        Visibility(
          visible: form.password.exception != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              if (_showException(form.password.exception?.isMinLengthValid))
                const Text('Password must be at least 8 characters'),
              const SizedBox(height: 5),
              if (_showException(form.password.exception?.isSpecialCharValid))
                const Text('Password must have special character'),
              const SizedBox(height: 5),
              if (_showException(form.password.exception?.isNumberValid))
                const Text('Password must have number'),
              const SizedBox(height: 5),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
        const SizedBox(height: 10),
        Text('Form is Valid: ${form.isValid}')
      ],
    );
  },
)
```

### Notion

When use FFormException for validation, you need override getter isValid for normalize validation result.

```dart
class PasswordException extends FFormException {

  @override
  bool get isValid => true; // validation result in FForm is valid 

  // or 

  @override
  bool get isValid => false; // validation result in FForm is not valid
} 

```

---

## Important Note 📝

The `allFieldUpdateCheck` in `FForm` property plays a critical role in determining how `FFormBuilder` reacts to updates in form fields. This property specifies whether every field update will trigger a rebuild of the `FFormBuilder` or if the rebuild occurs exclusively when the `isValid` or `isInvalid` getters are invoked.

- **When `allFieldUpdateCheck` is enabled (set to `true`)**: Any change to a field's value leads to an immediate rebuild of the `FFormBuilder`, ensuring the UI is always in sync with the form's state. This is ideal for forms where field interdependencies are common, and you need real-time feedback.

- **When `allFieldUpdateCheck` is disabled (set to `false`)**: `FFormBuilder` will only rebuild when you explicitly check the form's validity through `isValid` or `isInvalid`. This approach can enhance performance for forms with a large number of fields or complex validation rules, as it reduces the number of rebuilds.

Choose the setting that best fits your form's requirements and user experience goals. This feature offers you the flexibility to optimize form interactions and performance in your Flutter apps. 🚀

This README aims to guide you through the essentials of using the `FForm` for creating validated form and `FFormBuilder` for assembling and managing a form within your Flutter application, all while keeping things fresh and engaging. 🌟
