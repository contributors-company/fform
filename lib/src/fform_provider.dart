part of 'fform_builder.dart';

/// `FFormProvider` is a widget that provides a form to its descendants.
/// It is used to provide a form to its descendants.
class FFormProvider<T extends FForm> extends InheritedWidget {
  final T _form;

  const FFormProvider._({super.key, required super.child, required T form})
      : _form = form;

  /// Get the form from the context.
  static T of<T extends FForm>(BuildContext context) {
    final FFormProvider<T>? provider =
        context.dependOnInheritedWidgetOfExactType<FFormProvider<T>>();
    if (provider == null) {
      throw Exception('FFormProvider<$T> not found');
    }
    return provider._form;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
