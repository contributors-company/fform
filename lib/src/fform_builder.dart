import 'package:flutter/cupertino.dart';

import 'fform.dart';

/// FFormBuilder is a widget that builds a form and manages the state of the form.
/// It is used to create a form and manage the state of the form.
class FFormBuilder extends StatefulWidget {
  /// The form to be built and managed.
  final FForm form;

  /// The builder to build the form.
  final Widget Function(BuildContext context, FForm form) builder;

  /// Creates a FFormBuilder.
  const FFormBuilder({
    Key? key,
    required this.form,
    required this.builder,
  }) : super(key: key);

  @override
  FFormBuilderState createState() => FFormBuilderState();
}

class FFormBuilderState extends State<FFormBuilder> {
  @override
  void initState() {
    /// Listen to the stream of the form and update the state of the form.
    widget.form.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.form);
  }
}
