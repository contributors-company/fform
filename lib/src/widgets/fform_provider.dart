import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// `FFormProvider` is a widget that provides a form to its descendants.
/// It is used to provide a form to its descendants.
class FFormProvider<T extends FForm> extends InheritedNotifier<T> {
  /// Creates a FFormProvider.
  const FFormProvider({
    required super.child,
    required T form,
    super.key,
  }) : super(notifier: form);

  /// Retrieves the form from the context.
  static T? maybeOf<T extends FForm>(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<FFormProvider<T>>()
              ?.notifier
          : context.getInheritedWidgetOfExactType<FFormProvider<T>>()?.notifier;

  static Never _notFound() => throw ArgumentError(
      'FFormProvider.of() called with a context that does not contain a FFormProvider.');

  /// Retrieves the form from the context.
  static T of<T extends FForm>(BuildContext context, {bool listen = true}) =>
      maybeOf<T>(context, listen: listen) ?? _notFound();

  @override
  bool updateShouldNotify(covariant InheritedNotifier<T> oldWidget) =>
      notifier != oldWidget.notifier;
}
