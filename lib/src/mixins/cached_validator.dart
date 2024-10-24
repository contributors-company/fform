import 'package:fform/fform.dart';

/// {@template cache_field_mixin}
/// A mixin that caches validation results for form fields.
///
/// The `CacheField` mixin can be applied to any `FFormField` to cache the exceptions
/// resulting from validation checks. This improves performance by avoiding redundant validations
/// for the same input values.
///
/// ### Example
/// ```dart
/// class MyFormField extends FFormField<String, MyException> with CacheField<String, MyException> {
///   @override
///   MyException? validator(String value) {
///     // Implement your validation logic here
///     return value.isEmpty ? 'Value cannot be empty' : null;
///   }
/// }
/// ```
/// {@endtemplate}
mixin CacheField<T, E> on FFormField<T, E> {
  static const int _cacheSizeLimit = 50;

  final Map<String, E?> _cachedExceptions = <String, E?>{};

  /// {@template check_method}
  /// Overrides the `check` method to implement caching of validation results.
  ///
  /// If the current value has been validated before and the result is cached, it uses the cached
  /// exception instead of performing validation again.
  ///
  /// ### Example
  /// ```dart
  /// final isValid = await field.check();
  /// if (isValid) {
  ///   // Proceed knowing the field is valid
  /// } else {
  ///   // Handle validation errors
  /// }
  /// ```
  /// {@endtemplate}
  @override
  Future<bool> check() async {
    final key = value.toString();
    if (_cachedExceptions.containsKey(key)) {
      exception = _cachedExceptions[key];
      return isValid;
    }

    await super.check();

    _cachedExceptions[key] = exception;

    if (_cachedExceptions.length > _cacheSizeLimit) {
      _cachedExceptions.remove(_cachedExceptions.keys.first);
    }

    return isValid;
  }
}
