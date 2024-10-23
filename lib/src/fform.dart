import 'dart:async';

import 'package:collection/collection.dart';
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

  /// Observer of the form.
  static FFormObserver? observer;

  @override
  void dispose() {
    super.dispose();
    for (final field in fields) {
      field
        ..removeListener(notifyListeners)
        ..dispose();
    }
    for (final form in subForms) {
      form
        ..removeListener(notifyListeners)
        ..dispose();
    }
  }

  bool _hasCheck = false;

  /// Add a field to the form.
  @nonVirtual
  void addField(FFormField<_NullObject, _NullObject> field) {
    fields.add(field);
    field.addListener(notifyListeners);
  }

  /// Remove a field from the form.
  @nonVirtual
  void removeField(FFormField<_NullObject, _NullObject> field) {
    fields.remove(field);
    field.removeListener(notifyListeners);
  }

  /// Add a sub form to the form.
  @nonVirtual
  void addSubForm(FForm form) {
    subForms.add(form);
    form.addListener(notifyListeners);
  }

  /// Remove a sub form from the form.
  @nonVirtual
  void removeSubForm(FForm form) {
    subForms.remove(form);
    form.removeListener(notifyListeners);
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
    observer?.check(this);
    _hasCheck = true;
    notifyListeners();
    return isValid;
  }

  /// Get the first field of a specific type.
  @nonVirtual
  T get<T extends FFormField<_NullObject, _NullObject>>() => fields.whereType<T>().cast<T>().first;

  /// Check if the form has been checked.
  @nonVirtual
  bool get hasCheck => _hasCheck;

  /// List of all fields of the form.
  List<FFormField<_NullObject, _NullObject>> get _allFields => [...fields, ..._subFormFields];

  List<FFormField<_NullObject, _NullObject>> get _subFormFields =>
      [for (final subForm in subForms) ...subForm.fields];

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
  List<_NullObject> get exceptionFields => answerFields.where((element) => element != null).toList();

  /// List of exceptions of the sub forms.
  @nonVirtual
  List<_NullObject> get exceptionSubForms => answersSubForms.where((element) => element != null).toList();

  /// List of all exceptions of the fields and sub forms.
  @nonVirtual
  List<_NullObject> get exceptions => answers.where((element) => element != null).toList();

  /// Check if the form is valid.
  @nonVirtual
  bool get isValid => _allFields.fold(true, (previousValue, field) => previousValue && field.isValid);

  /// Check if the form is invalid.
  @nonVirtual
  bool get isInvalid => !isValid;

  /// Get the first field with an exception.
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get firstInvalidField =>
      _allFields.firstWhereOrNull((field) => field.isInvalid);

  ///Get the last field with an exception.
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get lastInvalidField =>
      _allFields.lastWhereOrNull((field) => field.isInvalid);
}
