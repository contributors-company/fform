import 'dart:async';

import 'package:fform/fform.dart';

/// A mixin that provides asynchronous validation for a form field.
///
/// This mixin should be used on a class that extends [FFormField].
mixin AsyncField<T, E> on FFormField<T, E> {
  /// A [Completer] that holds the future result of the asynchronous validation.
  Completer<E?>? completer;

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
  Future<E?> getAsyncException() async {
    completer = Completer<E?>();

    try {
      /// Perform the asynchronous validation.
      exception = await asyncValidator(value);
      completer?.complete(exception);
    } catch (error) {
      /// Complete the completer with an error if validation fails.
      completer?.completeError(error);
    } finally {
      /// Notify listeners after validation completes.
      notifyListeners();
    }

    return completer?.future;
  }
}
