import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

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
  ///
  /// ### Example
  /// ```dart
  /// final field = MyFormField(initialValue);
  /// ```
  FFormField(super.value) {
    check();
  }

  E? _exception;

  /// {@template exception_property}
  /// The exception associated with the field after validation.
  ///
  /// If the field is valid, this will be `null`.
  ///
  /// ### Example
  /// ```dart
  /// final exception = field.exception;
  /// if (exception != null) {
  ///   // Handle the validation exception
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  E? get exception => _exception;

  /// {@macro exception_property}
  @nonVirtual
  set exception(E? value) {
    if (identical(value, _exception)) return;
    _exception = value;
    notifyListeners();
  }

  /// {@template validator_method}
  /// Validates the current value of the field.
  ///
  /// Returns an exception of type `E` if the value is invalid, otherwise `null`.
  ///
  /// ### Example
  /// ```dart
  /// @override
  /// MyException? validator(MyValue value) {
  ///   if (value.isValid()) {
  ///     return null;
  ///   } else {
  ///     return MyException('Invalid value');
  ///   }
  /// }
  /// ```
  /// Or MyException extends FFormException, then required return type is FFormException
  /// ```dart
  /// @override
  /// MyException? validator(MyValue value) {
  ///  if (value.isValid()) {
  ///     return MyException(isValid: true);
  ///  } else {
  ///     return MyException(isValid: false, message: 'Invalid value');
  ///  }
  /// }
  /// ```
  /// {@endtemplate}
  E? validator(T value);

  /// {@template is_valid_property}
  /// Indicates whether the field's value is valid.
  ///
  /// Returns `true` if the field is valid, `false` otherwise.
  ///
  /// ### Example
  /// ```dart
  /// if (field.isValid) {
  ///   // Proceed with processing
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  bool get isValid {
    if (_exception case FFormException exception) return exception.isValid;

    return _exception == null;
  }

  /// {@template is_invalid_property}
  /// Indicates whether the field's value is invalid.
  ///
  /// Returns `true` if the field is invalid, `false` otherwise.
  ///
  /// ### Example
  /// ```dart
  /// if (field.isInvalid) {
  ///   // Display error message
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  bool get isInvalid => !isValid;

  /// {@template check_method}
  /// Validates the field and updates the exception state.
  ///
  /// If the field is valid after validation, it returns `true`.
  ///
  /// ### Example
  /// ```dart
  /// final isValid = await field.check();
  /// if (isValid) {
  ///   // Field is valid
  /// } else {
  ///   // Handle validation errors
  /// }
  /// ```
  /// {@endtemplate}
  @mustCallSuper
  Future<bool> check() async {
    switch (validator(value)) {
      case null:
        _exception = null;
      case FFormException exception:
        if (exception.isValid) {
          _exception = null;
        } else if (exception case E? e) {
          _exception = e;
        }
      case E exception:
        _exception = exception;
    }

    notifyListeners();
    return isValid;
  }
}
