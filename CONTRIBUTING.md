# Contributing to fform

Thank you for considering contributing to the **fform** project! Your contributions are highly appreciated and help make this project better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
    - [Reporting Bugs](#reporting-bugs)
    - [Suggesting Features](#suggesting-features)
    - [Improving Documentation](#improving-documentation)
    - [Submitting Pull Requests](#submitting-pull-requests)
- [Development Setup](#development-setup)
- [Coding Guidelines](#coding-guidelines)
- [Commit Messages](#commit-messages)
- [License](#license)

## How Can I Contribute?

### Reporting Bugs

If you find a bug, please open an issue and include:

- **Title**: A clear and descriptive title.
- **Description**: Detailed steps to reproduce the issue.
- **Expected Behavior**: What you expected to happen.
- **Actual Behavior**: What actually happened.
- **Screenshots**: If applicable, include screenshots.
- **Environment**: Dart and Flutter versions, OS, etc.

### Suggesting Features

We welcome feature suggestions. To suggest a feature:

- Open an issue with the label `enhancement`.
- Describe the feature in detail.
- Explain why it would be beneficial.

### Improving Documentation

Improving documentation is a great way to contribute:

- Fix typos or grammatical errors.
- Add usage examples or clarify existing ones.
- Update outdated information.

### Submitting Pull Requests

Before submitting a pull request:

1. **Fork the repository** and create a new branch.
2. **Ensure your code follows the [Coding Guidelines](#coding-guidelines)**.
3. **Include tests** for your changes.
4. **Update documentation** if necessary.
5. **Check for merge conflicts**.

To submit your pull request:

- Push your branch to your fork.
- Open a pull request against the `dev` branch.
- Provide a clear and detailed description of your changes.

## Development Setup

To set up the project locally:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/contributors-company/fform.git
   ```

2. **Navigate to the project directory**:

   ```bash
   cd fform
   ```

3. **Install dependencies**:

   ```bash
   make get
   ```
   
   or
   ```bash
   fvm flutter pub get
   ```

4. **Run tests**:

   ```bash
   make test
   ```
   or
   ```bash
    fvm flutter test
   ```

## Coding Guidelines

- **Language**: Use Dart and follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide.
- **Documentation**:
    - Use Dart's documentation comments (`///`).
    - Utilize templates and macros for reusable documentation.
    - Include usage examples where appropriate.
- **Formatting**: Use `make format` to format your code.
- **Linting**: Address any issues raised by `make analyze`
- **Pre Commit**: Use `make precommit`.

### Example Documentation Comment

```dart
/// {@template fform_field}
/// An abstract base class for all form fields.
///
/// Provides:
/// - A value of type `T`.
/// - A validator that returns an exception of type `E` if validation fails.
/// - Methods to check the validity of the field.
/// - Access to any validation exceptions.
/// {@endtemplate}
abstract class FFormField<T, E> extends ValueNotifier<T> {
  /// {@macro fform_field}
  FFormField(super.value) {
    check();
  }

  // ...
}
```

## Commit Messages

- **Format**: Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.
- **Structure**:

  ```
  <type>(<scope>): <subject>

  <body>

  <footer>
  ```

- **Types**:

    - `feat`: New features.
    - `fix`: Bug fixes.
    - `docs`: Documentation changes.
    - `style`: Code style changes (formatting, missing semicolons, etc.).
    - `refactor`: Code changes that neither fix a bug nor add a feature.
    - `test`: Adding or updating tests.
    - `chore`: Maintenance tasks.

### Example Commit Message

```
feat(form): add async validation support

Introduced AsyncField mixin to enable asynchronous validation in form fields.

Closes #123
```
