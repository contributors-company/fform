import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// FFormField is a base class for all form fields.
/// It has a value and a validator.
/// It has a method to check if the field is valid.
/// It has a method to check if the field is invalid.
/// It has a method to get the exception of the field.
abstract class FFormField<T, E> extends ValueNotifier<T> {
  /// Constructor of the class.
  FFormField(super.value) {
    check();
  }

  E? _exception;

  /// Exception of the field.
  @nonVirtual
  E? get exception => _exception;

  @nonVirtual
  set exception(E? value) {
    if (identical(value, exception)) return;
    _exception = value;
    notifyListeners();
  }

  /// Validator of the field.
  E? validator(T value);

  /// Check if the field is valid.
  @nonVirtual
  bool get isValid {
    if (_exception case FFormException exception) return exception.isValid;
    if (_exception == null) return true;
    if (_exception != null) return false;
    return true;
  }

  /// Check if the field is invalid.
  @nonVirtual
  bool get isInvalid => !isValid;

  /// Check if the field is valid.
  /// If the field is valid, it returns true.
  @mustCallSuper
  Future<bool> check() async {
    switch (validator(value)) {
      case null:
        {
          _exception = null;
        }
      case FFormException exception:
        {
          if (exception.isValid) _exception = null;
          if (exception case E? exception) {
            _exception = exception;
          }
        }
      case E exception:
        {
          _exception = exception;
        }
    }

    if (_exception != null) return isValid;

    return isValid;
  }
}
