# FForm Package 🚀

Let's dive into getting started with the FForm package, making it as straightforward and engaging as possible for new users. Here's a quick guide to help you hit the ground running with your Flutter form management. 🌈

---

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
- `FFormBuilder`: A widget that constructs and manages the form state, utilizing streams to refresh the UI dynamically as data changes.
- `FForm`: A base class for creating custom form classes, allowing you to add specific methods and properties to your forms.

## Why It Rocks 🎸

- **State Management Simplified**: Automatically handles the state of both individual form fields and the form as a whole.
- **Built-in Validation with a Twist**: Supports on-the-fly validation and error handling for each field, ensuring a smooth user experience.
- **Flexibility at Its Finest**: Supports any data type for field values and validation errors thanks to generics.
- **Reactive Forms for the Win**: Leverages streams for tracking form state changes, ensuring your UI is always in sync.

## Usage Examples

### Example 1: Creating a Form Field

```dart
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
  NameField(super.value);

  @override
  NameFieldException? validator(String value) {
    if (value.length <= 2) {
      return NameFieldException.min;
    } else {
      return null;
    }
  }
}

```

### Example 2: Extending FForm with LoginForm

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

### Example 3: Crafting a Form with FFormBuilder

```dart
class MyFormPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final FForm myForm = LoginForm(); // Assuming LoginForm is initialized with form fields

  @override
  Widget build(BuildContext context) {
    return FFormBuilder(
      form: myForm,
      builder: (context, form) {
        return Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  errorText: form.get<NameField>().exception.toString(),
                )
            ),
            ElevatedButton(
              onPressed: form.isValid ? () {} : null,
              child: Text('Submit 🚀'),
            ),
          ],
        );
      },
    );
  }
}
```




---

## Important Note 📝

The `allFieldUpdateCheck` property plays a critical role in determining how `FFormBuilder` reacts to updates in form fields. This property specifies whether every field update will trigger a rebuild of the `FFormBuilder` or if the rebuild occurs exclusively when the `isValid` or `isInvalid` getters are invoked.

- **When `allFieldUpdateCheck` is enabled (set to `true`)**: Any change to a field's value leads to an immediate rebuild of the `FFormBuilder`, ensuring the UI is always in sync with the form's state. This is ideal for forms where field interdependencies are common, and you need real-time feedback.

- **When `allFieldUpdateCheck` is disabled (set to `false`)**: `FFormBuilder` will only rebuild when you explicitly check the form's validity through `isValid` or `isInvalid`. This approach can enhance performance for forms with a large number of fields or complex validation rules, as it reduces the number of rebuilds.

Choose the setting that best fits your form's requirements and user experience goals. This feature offers you the flexibility to optimize form interactions and performance in your Flutter apps. 🚀

This README aims to guide you through the essentials of using the `FForm` for creating validated form and `FFormBuilder` for assembling and managing a form within your Flutter application, all while keeping things fresh and engaging. 🌟
