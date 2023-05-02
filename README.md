## FForm - form validator for flutter

#### Example FForm for login form
```dart

class LoginForm extends FForm {
  final NameField name;
  final PasswordField password;

  LoginForm({
    this.name = const NameField.pure(),
    this.password = const PasswordField.pure()
  });

  LoginForm copyWith({
    NameField? name,
    PasswordField? password,
  }) {
    return LoginForm(
      name: name ?? this.name,
      password: password ?? this.password
    );
  }
  
  @override
  List<FFormField> get fields => [name, password];
}

enum NameFieldException {
  min;

  @override
  String toString() {
    switch(this) {
      case min: return 'NameField.min.3';
    }
  }
}

class NameField extends FFormField<String, NameFieldException> {
  const NameField.pure() : super.pure('');
  NameField.dirty(super.value) : super.dirty();


  @override
  NameFieldException? validator(String value) {
    if(value.length <= 2) {
      return NameFieldException.min;
    } else {
      return null;
    }
  }
}

enum PasswordFieldException {
  min;

  @override
  String toString() {
    switch(this) {
      case min: return 'PasswordField.min.8';
    }
  }
}

class PasswordField extends FFormField<String, PasswordFieldException> {
  const PasswordField.pure() : super.pure('');
  PasswordField.dirty(super.value) : super.dirty();

  @override
  PasswordFieldException? validator(String value) {
    if(value.length <= 7) {
      return PasswordFieldException.min;
    } else {
      return null;
    }
  }
}
```

