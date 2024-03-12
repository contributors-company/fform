import 'dart:async';

part 'fform_field.dart';

/// FForm is a class that represents a form.
/// It has a list of fields and a list of answers.
/// It has a method to get the first field of a specific type.
/// It has a method to get the answers of the fields.
/// It has a method to get the exceptions of the fields.
/// It has a method to check if the form is valid.
/// It has a method to check if the form is invalid.
/// It has a stream controller to listen to changes in the form.
/// It has a method to set the form.
abstract class FForm {
  /// Constructor to initialize the form.
  FForm() {
    if (allFieldUpdateCheck) {
      for (var field in fields) {
        field.addListener((value) => notifyListeners());
      }
    }
  }

  /// Check if all fields are updated when a field is updated.
  bool get allFieldUpdateCheck => false;

  /// Stream controller to listen to changes in the form.
  final StreamController<FForm> _stream = StreamController<FForm>();

  /// Stream to listen to changes in the form.
  Stream<FForm> get stream => _stream.stream;

  /// List of fields of the form.
  List<FFormField> get fields;

  /// List of answers of the fields.
  List get answers => fields.map((e) => e.exception).toList();

  /// List of exceptions of the fields.
  List get exceptions => answers.where((element) => element != null).toList();

  /// Check if the form is valid.
  bool get isValid {
    notifyListeners();
    return exceptions.isEmpty;
  }

  /// Check if the form is invalid.
  bool get isInvalid {
    return !isValid;
  }

  /// Set the form.
  notifyListeners() {
    _stream.add(this);
  }

  /// Get the first field of a specific type.
  T get<T extends FFormField>() {
    return fields.firstWhere((element) => element is T) as T;
  }
}
