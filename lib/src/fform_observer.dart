// coverage:ignore-file

import 'package:fform/fform.dart';

/// {@template fform_observer}
/// An abstract class that can be used to observe the state of an [FForm].
///
/// Implement this class to perform actions when the form's state changes,
/// such as after validation checks.
/// {@endtemplate}
abstract class FFormObserver {
  /// {@macro fform_observer}
  ///
  /// ### Example
  /// ```dart
  /// class MyFormObserver extends FFormObserver {
  ///   @override
  ///   void check(FForm form) {
  ///     if (form.isValid) {
  ///       print('Form is valid.');
  ///     } else {
  ///       print('Form has errors.');
  ///     }
  ///   }
  /// }
  /// ```
  FFormObserver();

  /// {@template check_method}
  /// Called when the form's state changes due to a validation check.
  ///
  /// Override this method to handle form state changes.
  ///
  /// ### Example
  /// ```dart
  /// @override
  /// void check(FForm form) {
  ///   // Custom logic when the form is checked
  /// }
  /// ```
  /// {@endtemplate}
  ///
  void check(FForm form) {}
}
