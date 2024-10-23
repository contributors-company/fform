import 'package:fform/fform.dart';

/// An abstract class that can be used to observe the [FForm] state.
abstract class FFormObserver {
  /// A method that is called when the form state changes.
  void check(FForm form) {}
}
