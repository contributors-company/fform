import 'package:flutter/widgets.dart';

/// A mixin that provides a key to the field.
mixin KeyedField {
  /// The key of the field.
  final GlobalKey key = GlobalKey();
}
