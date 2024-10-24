import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// {@template keyed_field_mixin}
/// A mixin that provides a [GlobalKey] to the form field.
///
/// The `KeyedField` mixin can be applied to any `FFormField` to associate a unique [GlobalKey]
/// with the field. This is useful for referencing the field in the widget tree,
/// managing focus, scrolling, or accessing the widget's state.
///
/// ### Example
/// ```dart
/// class MyFormField extends FFormField<String, MyException> with KeyedField<String, MyException> {
///   @override
///   MyException? validator(String value) {
///     // Implement your validation logic here
///     return null;
///   }
/// }
///
/// // Usage:
/// final field = MyFormField();
/// // Access the key:
/// final key = field.key;
/// ```
/// {@endtemplate}
mixin KeyedField<T, E> on FFormField<T, E> {
  /// {@template key_property}
  /// The [GlobalKey] associated with the field.
  ///
  /// This key can be used to uniquely identify the widget corresponding to the field
  /// in the widget tree.
  ///
  /// ### Example
  /// ```dart
  /// // In your widget:
  /// Widget build(BuildContext context) {
  ///   return TextFormField(
  ///     key: field.key,
  ///     // Other properties
  ///   );
  /// }
  /// ```
  /// {@endtemplate}
  final GlobalKey key = GlobalKey();
}
