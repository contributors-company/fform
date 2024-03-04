part of 'fform.dart';

/// FFormField is a base class for all form fields.
/// It has a value and a validator.
/// It has a method to check if the field is valid.
/// It has a method to check if the field is invalid.
/// It has a method to get the exception of the field.
abstract class FFormField<T, E> {
  final T value;
  const FFormField._({required this.value});

  const FFormField.pure(T value) : this._(value: value);
  FFormField.dirty(T value) : this._(value: value);

  /// Validator of the field.
  E? validator(T value);

  /// Check if the field is valid.
  bool get isValid => exception == null;

  /// Check if the field is invalid.
  bool get isNotValid => !isValid;

  /// Get the exception of the field.
  E? get exception => validator(value);

  /// Check if the field is valid.
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
