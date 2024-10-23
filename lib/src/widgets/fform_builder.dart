import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// FFormWidgetBuilder is a function that builds a form widget.
typedef FFormWidgetBuilder<T extends FForm> = Widget Function(BuildContext context, T form);

/// FFormBuilder is a widget that builds a form and manages the state of the form.
/// It is used to create a form and manage the state of the form.
class FFormBuilder<T extends FForm> extends StatelessWidget {
  /// Creates a FFormBuilder.
  const FFormBuilder({
    required this.form,
    required this.builder,
    super.key,
  });

  /// The form to be built and managed.
  final T form;

  /// The builder to build the form.
  final FFormWidgetBuilder<T> builder;

  /// Build the form using the builder.
  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: form,
        builder: (context, child) => FFormProvider<T>(
          form: form,
          child: Builder(
            builder: (context) => builder(
              context,
              form,
            ),
          ),
        ),
      );
}
