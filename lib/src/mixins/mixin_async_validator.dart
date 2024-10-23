import 'dart:async';

import 'package:fform/fform.dart';

/// A mixin that provides asynchronous validation for a form field.
///
/// This mixin should be used on a class that extends [FFormField].
mixin AsyncField<T, E> on FFormField<T, E> {
  /// An asynchronous validator that should be overridden to provide custom validation logic.
  ///
  /// Returns a [Future] that completes with an error of type [E] if validation fails,
  /// or `null` if validation succeeds.
  Future<E?> asyncValidator(T value);

  /// Retrieves the result of the asynchronous validation.
  ///
  /// If there is an active validation, it returns its [Future]. Otherwise, it starts a new
  /// validation by calling [asyncValidator] and returns its [Future].
  ///
  /// Returns a [Future] that completes with an error of type [E] if validation fails,
  /// or `null` if validation succeeds.
  @override
  Future<bool> check() async {
    if (!await super.check()) return false;

    exception = await asyncValidator(value);

    return isValid;
  }
}
