part 'fform_field.dart';

/// FFormListener is a function that takes a FForm as a parameter.
typedef FFormListener = void Function(FForm value);

/// FForm is a class that represents a form.
/// It has a list of fields and a list of answers.
/// It has a method to get the first field of a specific type.
/// It has a method to get the answers of the fields.
/// It has a method to get the exceptions of the fields.
/// It has a method to check if the form is valid.
/// It has a method to check if the form is invalid.
abstract class FForm {
  /// Constructor to initialize the form.
  FForm() {
    if (allFieldUpdateCheck) {
      for (var field in fields) {
        field.addListener((value) => notifyListeners());
      }
    }
  }

  /// listeners of the form.
  final List<FFormListener> _listeners = [];

  /// add listener to the form.
  addListener(FFormListener listener) {
    _listeners.add(listener);
  }

  /// remove listener from the form.
  removeListener(FFormListener listener) {
    _listeners.remove(listener);
  }

  /// Check if all fields are updated when a field is updated.
  bool get allFieldUpdateCheck => false;

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
    for (var listener in _listeners) {
      listener(this);
    }
  }

  /// Get the first field of a specific type.
  T get<T extends FFormField>() {
    return fields.firstWhere((element) => element is T) as T;
  }
}
