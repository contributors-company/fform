import 'package:flutter/cupertino.dart';

part 'fform_field.dart';

/// FFormListener is a function that takes a FForm as a parameter.
typedef FFormListener<T extends FForm> = void Function();

/// FForm is a class that represents a form.
/// It has a list of fields and a list of answers.
/// It has a method to get the first field of a specific type.
/// It has a method to get the answers of the fields.
/// It has a method to get the exceptions of the fields.
/// It has a method to check if the form is valid.
/// It has a method to check if the form is invalid.
abstract class FForm {
  /// Check if the form has been checked.
  bool hasCheck = false;

  /// Constructor to initialize the form.
  FForm() {
    if (allFieldUpdateCheck) {
      for (var field in fields) {
        field.addListener((value) => notifyListeners());
      }
    }
  }

  /// List of listeners of the form.
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

  List<FFormField> get _allFields =>
      [...fields, ...subForms.expand((element) => element._allFields)];

  /// List of sub forms of the form.
  List<FForm> get subForms => [];

  /// List of answers of the fields.
  List get answers => fields.map((e) => e.exception).toList();

  /// List of answers of the sub forms.
  List get answersSubForms =>
      [for (var subForm in subForms) ...subForm.answers];

  /// List of all answers of the fields and sub forms.
  List get allAnswers => [...answers, ...answersSubForms];

  /// List of exceptions of the fields.
  List get exceptions => answers.where((element) => element != null).toList();

  /// List of exceptions of the sub forms.
  List get exceptionsSubForms =>
      answersSubForms.where((element) => element != null).toList();

  /// List of all exceptions of the fields and sub forms.
  List get allExceptions =>
      allAnswers.where((element) => element != null).toList();

  /// Check if the form is valid.
  bool get isValid {
    for (var element in subForms) {
      element.isValid;
    }
    hasCheck = true;
    notifyListeners();
    return allExceptions.isEmpty;
  }

  /// Check if the form is invalid.
  bool get isInvalid {
    return !isValid;
  }

  /// Get the first field with an exception.
  FFormField? get firstInvalidField {
    for (var field in _allFields) {
      if (field.exception != null) {
        return field;
      }
    }
    return null;
  }

  ///Get the last field with an exception.
  FFormField? get lastInvalidField {
    for (var field in _allFields.reversed) {
      if (field.exception != null) {
        return field;
      }
    }
    return null;
  }

  /// Set the form.
  notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  /// Get the first field of a specific type.
  T get<T extends FFormField>() {
    return fields.firstWhere((element) => element is T) as T;
  }
}
