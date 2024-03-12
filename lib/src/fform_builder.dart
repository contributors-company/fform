import 'package:flutter/cupertino.dart';

import 'fform.dart';

/// FFormBuilder is a widget that builds a form and manages the state of the form.
/// It is used to create a form and manage the state of the form.
class FFormBuilder<F extends FForm> extends StatefulWidget {
  /// The form to be built and managed.
  final F form;

  /// The builder to build the form.
  final Widget Function(BuildContext context, F form) builder;

  /// Creates a FFormBuilder.
  const FFormBuilder({
    super.key,
    required this.form,
    required this.builder,
  });

  @override
  FFormBuilderState createState() => FFormBuilderState();
}

class FFormBuilderState extends State<FFormBuilder> {
  @override
  void initState() {
    /// Listen to the stream of the form and update the state of the form.
    widget.form.addListener((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.form);
  }
}
