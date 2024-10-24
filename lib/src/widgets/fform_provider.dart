import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// {@template fform_provider_class}
/// A widget that provides an [FForm] instance to its descendants.
///
/// [FFormProvider] is used to make a form available to widgets lower in the
/// widget tree, allowing them to access and interact with the form's state.
///
/// ### Example
/// ```dart
/// final form = MyForm();
///
/// FFormProvider<MyForm>(
///   form: form,
///   child: MyFormWidget(),
/// );
/// ```
/// {@endtemplate}
class FFormProvider<T extends FForm> extends InheritedNotifier<T> {
  /// {@macro fform_provider_class}
  ///
  /// Creates an [FFormProvider].
  ///
  /// ### Parameters
  /// - [form]: The [FForm] instance to provide to descendants.
  /// - [child]: The widget below this widget in the tree.
  ///
  /// ### Example
  /// ```dart
  /// FFormProvider<MyForm>(
  ///   form: form,
  ///   child: MyFormWidget(),
  /// );
  /// ```
  const FFormProvider({
    required super.child,
    required T form,
    super.key,
  }) : super(notifier: form);

  /// {@template maybe_of_method}
  /// Retrieves the [FForm] instance from the closest [FFormProvider] in the widget tree.
  ///
  /// Returns `null` if no [FFormProvider] is found.
  ///
  /// ### Parameters
  /// - [context]: The [BuildContext] to search within.
  /// - [listen]: Whether to establish a dependency on the [FFormProvider].
  ///   - If `true`, the widget will rebuild when the form changes.
  ///   - If `false`, the widget will not rebuild when the form changes.
  ///
  /// ### Example
  /// ```dart
  /// final form = FFormProvider.maybeOf<MyForm>(context);
  /// if (form != null) {
  ///   // Use the form
  /// }
  /// ```
  /// {@endtemplate}
  static T? maybeOf<T extends FForm>(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<FFormProvider<T>>()
              ?.notifier
          : context.getInheritedWidgetOfExactType<FFormProvider<T>>()?.notifier;

  static Never _notFound() => throw ArgumentError(
      'FFormProvider.of() called with a context that does not contain an FFormProvider.');

  /// {@template of_method}
  /// Retrieves the [FForm] instance from the closest [FFormProvider] in the widget tree.
  ///
  /// Throws an [ArgumentError] if no [FFormProvider] is found.
  ///
  /// ### Parameters
  /// - [context]: The [BuildContext] to search within.
  /// - [listen]: Whether to establish a dependency on the [FFormProvider].
  ///   - If `true`, the widget will rebuild when the form changes.
  ///   - If `false`, the widget will not rebuild when the form changes.
  ///
  /// ### Example
  /// ```dart
  /// final form = FFormProvider.of<MyForm>(context);
  /// // Use the form
  /// ```
  /// {@endtemplate}
  static T of<T extends FForm>(BuildContext context, {bool listen = true}) =>
      maybeOf<T>(context, listen: listen) ?? _notFound();

  /// {@template update_should_notify_method}
  /// Determines whether the [FFormProvider] should notify its dependents when the
  /// [notifier] changes.
  ///
  /// Returns `true` if the [notifier] is different from the [oldWidget]'s notifier.
  ///
  /// ### Parameters
  /// - [oldWidget]: The previous widget instance to compare with.
  ///
  /// ### Example
  /// This method is typically not called directly.
  /// {@endtemplate}
  @override
  bool updateShouldNotify(covariant InheritedNotifier<T> oldWidget) =>
      notifier != oldWidget.notifier;
}
