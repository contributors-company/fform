/// {@template fform_exception}
/// An abstract class representing an exception for form fields.
///
/// Provides a method to check if the exception indicates a valid state.
/// {@endtemplate}
abstract class FFormException {
  /// {@macro fform_exception}
  ///
  /// ### Example
  /// ```dart
  /// class MyException extends FFormException {
  ///   @override
  ///   bool get isValid => false;
  /// }
  /// ```
  FFormException();

  /// {@template is_valid_property}
  /// Indicates whether the exception represents a valid state.
  ///
  /// Returns `true` if the exception is considered valid.
  ///
  /// ### Example
  /// ```dart
  /// if (exception.isValid) {
  ///   // Proceed despite the exception
  /// } else {
  ///   // Handle the error
  /// }
  /// ```
  /// {@endtemplate}
  bool get isValid;
}
