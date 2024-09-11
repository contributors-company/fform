part of 'fform.dart';

/// FFormException is a class that holds the exception of the field.
/// It has a method to check if the exception is valid.
abstract class FFormException {
  /// Check if the exception is valid.
  /// If the exception is valid, it returns true.
  bool get isValid;
}
