library fform;

abstract class FForm {
  List<FFormField> get fields;

  List get answers => fields.map((e) => e.exception).toList();

  List get exceptions => answers.where((element) => element != null).toList();

  bool get isValid => exceptions.isEmpty;

  bool get isInvalid => exceptions.isNotEmpty;
}

class FFormValidator {
  final List<FFormField> fields;

  FFormValidator(this.fields);

  FFormValidator.pure({this.fields = const []});

  List get answers => fields.map((e) => e.exception).toList();

  List get exceptions => answers.where((element) => element != null).toList();

  bool get isValid => exceptions.isEmpty;

  bool get isInvalid => exceptions.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FFormValidator &&
        other.fields == fields &&
        other.isValid == isValid;
  }

  @override
  int get hashCode => Object.hashAll([fields, isValid]);
}

abstract class FFormField<T, E> {
  final T value;
  const FFormField._({required this.value});

  const FFormField.pure(T value) : this._(value: value);
  FFormField.dirty(T value) : this._(value: value);

  E? validator(T value);

  bool get isValid => exception == null;

  bool get isNotValid => !isValid;

  E? get exception => validator(value);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FFormField<T, E> &&
        other.value == value &&
        other.isValid == isValid;
  }

  @override
  int get hashCode => Object.hashAll([value, isValid]);
}
