import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fform/fform.dart';
import 'package:flutter/foundation.dart';

typedef _NullObject = Object?;

/// {@template fform_class}
/// An abstract class representing a form.
///
/// Provides methods and properties to manage form fields and subforms,
/// including validation checks, adding/removing fields, and accessing exceptions.
/// {@endtemplate}
abstract class FForm extends ChangeNotifier {
  /// {@macro fform_class}
  ///
  /// ### Example
  /// ```dart
  /// final form = MyForm();
  /// ```
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

  /// {@template fields_list}
  /// The list of fields within the form.
  ///
  /// ### Example
  /// ```dart
  /// final field = MyFormField();
  /// form.fields.add(field);
  /// ```
  /// {@endtemplate}
  List<FFormField<_NullObject, _NullObject>> fields;

  /// {@template subforms_list}
  /// The list of subforms contained within this form.
  ///
  /// ### Example
  /// ```dart
  /// final subForm = MySubForm();
  /// form.subForms.add(subForm);
  /// ```
  /// {@endtemplate}
  List<FForm> subForms;

  /// {@template observer_field}
  /// An optional observer for monitoring form checks.
  ///
  /// ### Example
  /// ```dart
  /// FForm.observer = MyFormObserver();
  /// ```
  /// {@endtemplate}
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

  /// {@template add_field_method}
  /// Adds a field to the form and starts listening for changes.
  ///
  /// ### Example
  /// ```dart
  /// final field = MyFormField();
  /// form.addField(field);
  /// ```
  /// {@endtemplate}
  @nonVirtual
  void addField(FFormField<_NullObject, _NullObject> field) {
    fields.add(field);
    field.addListener(notifyListeners);
  }

  /// {@template remove_field_method}
  /// Removes a field from the form and stops listening for changes.
  ///
  /// ### Example
  /// ```dart
  /// form.removeField(field);
  /// ```
  /// {@endtemplate}
  @nonVirtual
  void removeField(FFormField<_NullObject, _NullObject> field) {
    fields.remove(field);
    field.removeListener(notifyListeners);
  }

  /// {@template add_subform_method}
  /// Adds a subform to the form and starts listening for changes.
  ///
  /// ### Example
  /// ```dart
  /// final subForm = MySubForm();
  /// form.addSubForm(subForm);
  /// ```
  /// {@endtemplate}
  @nonVirtual
  void addSubForm(FForm form) {
    subForms.add(form);
    form.addListener(notifyListeners);
  }

  /// {@template remove_subform_method}
  /// Removes a subform from the form and stops listening for changes.
  ///
  /// ### Example
  /// ```dart
  /// form.removeSubForm(subForm);
  /// ```
  /// {@endtemplate}
  @nonVirtual
  void removeSubForm(FForm form) {
    subForms.remove(form);
    form.removeListener(notifyListeners);
  }

  /// {@template check_async_method}
  /// Asynchronously checks if the form is valid by validating all fields and subforms.
  ///
  /// Returns `true` if the form is valid after validation.
  ///
  /// ### Example
  /// ```dart
  /// final isValid = await form.checkAsync();
  /// ```
  /// {@endtemplate}
  @nonVirtual
  Future<bool> checkAsync() async {
    await Future.wait([for (final element in _allFields) element.check()]);
    return _check();
  }

  /// {@template check_method}
  /// Synchronously checks if the form is valid by initiating validation on all fields and subforms.
  ///
  /// Returns `true` if the form is valid after validation.
  ///
  /// ### Example
  /// ```dart
  /// final isValid = form.check();
  /// ```
  /// {@endtemplate}
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

  /// {@template get_field_method}
  /// Retrieves the first field of the specified type `T`.
  ///
  /// Throws a `StateError` if no such field is found.
  ///
  /// ### Example
  /// ```dart
  /// final textField = form.get<MyTextField>();
  /// ```
  /// {@endtemplate}
  @nonVirtual
  T get<T extends FFormField<_NullObject, _NullObject>>() =>
      fields.whereType<T>().cast<T>().first;

  /// {@template has_check_property}
  /// Indicates whether the form has been checked at least once.
  ///
  /// ### Example
  /// ```dart
  /// if (form.hasCheck) {
  ///   // Perform actions after the form has been checked
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  bool get hasCheck => _hasCheck;

  List<FFormField<_NullObject, _NullObject>> get _allFields =>
      [...fields, ..._subFormFields];

  List<FFormField<_NullObject, _NullObject>> get _subFormFields =>
      [for (final subForm in subForms) ...subForm.fields];

  /// {@template answer_fields_property}
  /// A list of exceptions (answers) from the fields in this form.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.answerFields;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get answerFields => fields.map((e) => e.exception).toList();

  /// {@template answers_subforms_property}
  /// A list of exceptions (answers) from the fields in the subforms.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.answersSubForms;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get answersSubForms => [
        for (final subForm in subForms) ...subForm.answerFields,
      ];

  /// {@template answers_property}
  /// A combined list of exceptions (answers) from all fields and subforms.
  ///
  /// ### Example
  /// ```dart
  /// final allExceptions = form.answers;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get answers => [
        ...answerFields,
        ...answersSubForms,
      ];

  /// {@template exception_fields_property}
  /// A list of non-null exceptions from the fields in this form.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.exceptionFields;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get exceptionFields =>
      answerFields.where((element) => element != null).toList();

  /// {@template exception_subforms_property}
  /// A list of non-null exceptions from the fields in the subforms.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.exceptionSubForms;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get exceptionSubForms =>
      answersSubForms.where((element) => element != null).toList();

  /// {@template exceptions_property}
  /// A combined list of all non-null exceptions from the fields and subforms.
  ///
  /// ### Example
  /// ```dart
  /// final allExceptions = form.exceptions;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  List<_NullObject> get exceptions =>
      answers.where((element) => element != null).toList();

  /// {@template is_valid_property}
  /// Indicates whether all fields in the form are valid.
  ///
  /// Returns `true` if all fields are valid.
  ///
  /// ### Example
  /// ```dart
  /// if (form.isValid) {
  ///   // Proceed with form submission
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  bool get isValid => _allFields.fold(
      true, (previousValue, field) => previousValue && field.isValid);

  /// {@template is_invalid_property}
  /// Indicates whether any field in the form is invalid.
  ///
  /// Returns `true` if any field is invalid.
  ///
  /// ### Example
  /// ```dart
  /// if (form.isInvalid) {
  ///   // Display validation errors
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  bool get isInvalid => !isValid;

  /// {@template first_invalid_field_property}
  /// Retrieves the first field that is invalid, or `null` if all fields are valid.
  ///
  /// ### Example
  /// ```dart
  /// final invalidField = form.firstInvalidField;
  /// if (invalidField != null) {
  ///   // Focus on the first invalid field
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get firstInvalidField =>
      _allFields.firstWhereOrNull((field) => field.isInvalid);

  /// {@template last_invalid_field_property}
  /// Retrieves the last field that is invalid, or `null` if all fields are valid.
  ///
  /// ### Example
  /// ```dart
  /// final invalidField = form.lastInvalidField;
  /// if (invalidField != null) {
  ///   // Handle the last invalid field
  /// }
  /// ```
  /// {@endtemplate}
  @nonVirtual
  FFormField<_NullObject, _NullObject>? get lastInvalidField =>
      _allFields.lastWhereOrNull((field) => field.isInvalid);
}
