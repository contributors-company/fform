import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// FFormWidgetBuilder is a function that builds a form widget.
typedef FFormWidgetBuilder<T> = Widget Function(BuildContext context, T form);

/// FFormBuilder is a widget that builds a form and manages the state of the form.
/// It is used to create a form and manage the state of the form.
class FFormBuilder<T extends FForm> extends StatefulWidget {
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

  @override
  State<FFormBuilder<T>> createState() => FFormBuilderState<T>();
}

/// The state of the FFormBuilder.
class FFormBuilderState<T extends FForm> extends State<FFormBuilder<T>> {
  @override
  void initState() {
    super.initState();

    /// Add a listener to the stream of the form.
    widget.form.addListener(_listenForm);
  }

  @override
  void didUpdateWidget(covariant FFormBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.form == widget.form) return;

    /// Remove the listener to the stream of the old form.
    oldWidget.form.removeListener(_listenForm);

    /// Add a listener to the stream of the new form.
    widget.form.addListener(_listenForm);
  }

  @override
  void dispose() {
    super.dispose();

    /// Remove the listener to the stream of the form.
    widget.form.removeListener(_listenForm);
  }

  /// Listen to the form and update the state.
  void _listenForm() => setState(() {});

  /// Build the form using the builder.
  @override
  Widget build(BuildContext context) => FFormProvider<T>(
        notifier: widget.form,
        child: Builder(
          builder: (context) => widget.builder(
            context,
            widget.form,
          ),
        ),
      );
}
