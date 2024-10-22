import 'dart:async';

import 'package:fform/fform.dart';
import 'package:flutter/foundation.dart';

typedef _NullObject = Object?;

/// FForm is a class that represents a form.
/// It has a list of fields and a list of answers.
/// It has a method to get the first field of a specific type.
/// It has a method to get the answers of the fields.
/// It has a method to get the exceptions of the fields.
/// It has a method to check if the form is valid.
/// It has a method to check if the form is invalid.
abstract class FForm extends ChangeNotifier {
  /// Constructor to initialize the form.
  FForm({
    this.fields = const [],
    this.subForms = const [],
  }) {
    for (final field in fields) {
      field.addListener(notifyListeners);
    }
    for (final form in subForms) {
      form.addListener(notifyListeners);
    }
  }

  /// List of fields of the form.
  List<FFormField<_NullObject, _NullObject>> fields;

  /// List of sub forms of the form.

  List<FForm> subForms;

  @override
  void dispose() {
    super.dispose();
    for (final field in fields) {
      field..removeListener(notifyListeners)..dispose();
    }
    for (final form in subForms) {
      form..removeListener(notifyListeners)..dispose();
    }
  }

  /// Check if the form has been checked.
  @nonVirtual
  bool get hasCheck => _hasCheck;
  bool _hasCheck = false;

  /// Add a field to the form.
  @nonVirtual
  void addField(FFormField<_NullObject, _NullObject> field) {
    field.addListener(notifyListeners);
    fields.add(field);
  }

  /// Remove a field from the form.
  @nonVirtual
  void removeField(FFormField<_NullObject, _NullObject> field) {
    field.removeListener(notifyListeners);
    fields.remove(field);
  }

  /// Add a sub form to the form.
  @nonVirtual
  void addSubForm(FForm form) {
    form.addListener(notifyListeners);
    subForms.add(form);
  }

  /// Remove a sub form from the form.
  @nonVirtual
  void removeSubForm(FForm form) {
    form.removeListener(notifyListeners);
    subForms.remove(form);
  }

  /// Check if the form is valid.
  @nonVirtual
  Future<bool> checkAsync() async {
    await Future.wait([for (final element in _allFields) element.check()]);
    return _check();
  }

  /// Check if the form is valid.
  @nonVirtual
  bool check() {
    Future.wait([for (final element in _allFields) element.check()]);
    return _check();
  }

  bool _check() {
    _hasCheck = true;
    notifyListeners();
    return isValid;
  }

  /// Get the first field of a specific type.
  @nonVirtual
  T get<T extends FFormField<_NullObject, _NullObject>>() =>
      fields.whereType<T>() as T;

  /// List of all fields of the form.
  List<FFormField<_NullObject, _NullObject>> get _allFields => [
        ...fields,
        ...subForms.expand((element) => element._allFields),
      ];

  /// List of answers of the fields.
  @nonVirtual
  List<_NullObject> get answerFields => fields.map((e) => e.exception).toList();

  /// List of answers of the sub forms.
  @nonVirtual
  List<_NullObject> get answersSubForms => [
        for (final subForm in subForms) ...subForm.answerFields,
      ];

  /// List of all answers of the fields and sub forms.
  @nonVirtual
  List<_NullObject> get answers => [
        ...answerFields,
        ...answersSubForms,
      ];

  /// List of exceptions of the fields.
  @nonVirtual
  List<_NullObject> get exceptionFields =>
      answerFields.where((element) => element != null).toList();

  /// List of exceptions of the sub forms.
  @nonVirtual
  List<_NullObject> get exceptionSubForms =>
      answersSubForms.where((element) => element != null).toList();

  /// List of all exceptions of the fields and sub forms.
  @nonVirtual
  List<_NullObject> get exceptions =>
      answers.where((element) => element != null).toList();

  /// Check if the form is valid.
  @nonVirtual
  bool get isValid => exceptions.isEmpty;

  /// Check if the form is invalid.
  @nonVirtual
  bool get isInvalid => !isValid;

  /// Get the first field with an exception.
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get firstInvalidField {
    for (final field in _allFields) {
      if (field.isInvalid) return field;
    }
    return null;
  }

  ///Get the last field with an exception.
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get lastInvalidField {
    for (final field in _allFields.reversed) {
      if (field.isInvalid) return field;
    }
    return null;
  }

  /// Check if the field is valid.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return false;
    return other is FForm &&
        other.answers == answers &&
        other.isValid == isValid;
  }

  /// Check if the field is valid.
  @override
  int get hashCode => Object.hashAll([fields, isValid]);
}
