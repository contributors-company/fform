import 'dart:async';

import 'package:fform/fform.dart';

/// {@template async_field_mixin}
/// A mixin that provides asynchronous validation for a form field.
///
/// This mixin should be used on a class that extends [FFormField].
///
/// ### Example
/// ```dart
/// class MyAsyncFormField extends FFormField<String, MyException> with AsyncField<String, MyException> {
///   @override
///   Future<MyException?> asyncValidator(String value) async {
///     // Perform asynchronous validation, e.g., server-side checks
///     // Return an instance of MyException if validation fails, or null if it succeeds
///   }
///
///   @override
///   MyException? validator(String value) {
///     // Optional synchronous validation before the async validation
///     return null;
///   }
/// }
/// ```
/// {@endtemplate}
mixin AsyncField<T, E> on FFormField<T, E> {
  /// {@template async_validator_method}
  /// An asynchronous validator that should be overridden to provide custom validation logic.
  ///
  /// Returns a [Future] that completes with an exception of type `E` if validation fails,
  /// or `null` if validation succeeds.
  ///
  /// ### Example
  /// ```dart
  /// @override
  /// Future<MyException?> asyncValidator(String value) async {
  ///   // Perform asynchronous validation logic
  ///   final isValid = await someAsyncCheck(value);
  ///   return isValid ? null : MyException('Validation failed');
  /// }
  /// ```
  /// {@endtemplate}
  Future<E?> asyncValidator(T value);

  /// {@template check_method}
  /// Validates the field asynchronously and updates the exception state.
  ///
  /// It first performs synchronous validation using [super.check]. If that passes,
  /// it proceeds to asynchronous validation by calling [asyncValidator].
  ///
  /// Returns a [Future] that completes with `true` if the field is valid after validation,
  /// or `false` if it is invalid.
  ///
  /// ### Example
  /// ```dart
  /// final isValid = await field.check();
  /// if (isValid) {
  ///   // Proceed with valid data
  /// } else {
  ///   // Handle validation errors
  /// }
  /// ```
  /// {@endtemplate}
  @override
  Future<bool> check() async {
    if (!await super.check()) return false;

    exception = await asyncValidator(value);

    notifyListeners();
    return isValid;
  }
}
