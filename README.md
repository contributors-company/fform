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




---

## Important Note 📝

The `allFieldUpdateCheck` property plays a critical role in determining how `FFormBuilder` reacts to updates in form fields. This property specifies whether every field update will trigger a rebuild of the `FFormBuilder` or if the rebuild occurs exclusively when the `isValid` or `isInvalid` getters are invoked.

- **When `allFieldUpdateCheck` is enabled (set to `true`)**: Any change to a field's value leads to an immediate rebuild of the `FFormBuilder`, ensuring the UI is always in sync with the form's state. This is ideal for forms where field interdependencies are common, and you need real-time feedback.

- **When `allFieldUpdateCheck` is disabled (set to `false`)**: `FFormBuilder` will only rebuild when you explicitly check the form's validity through `isValid` or `isInvalid`. This approach can enhance performance for forms with a large number of fields or complex validation rules, as it reduces the number of rebuilds.

Choose the setting that best fits your form's requirements and user experience goals. This feature offers you the flexibility to optimize form interactions and performance in your Flutter apps. 🚀

This README aims to guide you through the essentials of using the `FForm` for creating validated form and `FFormBuilder` for assembling and managing a form within your Flutter application, all while keeping things fresh and engaging. 🌟
