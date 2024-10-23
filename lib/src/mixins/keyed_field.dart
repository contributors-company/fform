import 'package:fform/fform.dart';
import 'package:flutter/widgets.dart';

/// A mixin that provides a key to the field.
mixin KeyedField<T, E> on FFormField<T, E> {
  /// The key of the field.
  final GlobalKey key = GlobalKey();
}
