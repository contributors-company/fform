import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fform/fform.dart';
import 'package:flutter/foundation.dart';

typedef _NullObject = Object?;

/// Represents the various states of a form (`FForm`).
enum FFormStatus {
  /// The initial state of the form before any validation or action occurs.
  ///
  /// Example:
  /// ```dart
  /// final form = MockForm();
  /// print(form.status); // Outputs: FFormStatus.initial
  /// ```
  initial,

  /// The state when the form is actively performing an operation,
  /// such as validation or submission.
  ///
  /// Example:
  /// ```dart
  /// form.checkAsync();
  /// print(form.status); // Outputs: FFormStatus.loading
  /// ```
  loading,

  /// The state when the form has successfully completed its operation
  /// with no validation errors.
  ///
  /// Example:
  /// ```dart
  /// form.check();
  /// print(form.status); // Outputs: FFormStatus.success if all validations pass
  /// ```
  success,

  /// The state when the form encounters validation errors or other issues.
  ///
  /// Example:
  /// ```dart
  /// form.check();
  /// print(form.status); // Outputs: FFormStatus.exception if validation fails
  /// ```
  exception,
}

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
    List<FFormField<_NullObject, _NullObject>>? fields,
    List<FForm>? subForms,
  })  : _fields = fields ?? [],
        _subForms = subForms ?? [] {
    for (final field in _fields) {
      field.addListener(notifyListeners);
    }
    for (final form in _subForms) {
      form.addListener(notifyListeners);
    }
  }

  final List<FFormField<_NullObject, _NullObject>> _fields;

  /// {@template fields_list}
  /// The list of fields within the form.
  ///
  /// ### Example
  /// ```dart
  /// final field = MyFormField();
  /// form.fields.add(field);
  /// ```
  /// {@endtemplate}
  List<FFormField<_NullObject, _NullObject>> get fields =>
      List.unmodifiable(_fields);

  final List<FForm> _subForms;

  /// {@template subforms_list}
  /// The list of subforms contained within this form.
  ///
  /// ### Example
  /// ```dart
  /// final subForm = MySubForm();
  /// form.subForms.add(subForm);
  /// ```
  /// {@endtemplate}
  List<FForm> get subForms => List.unmodifiable(_subForms);

  bool _hasCheck = false;

  FFormStatus _status = FFormStatus.initial;

  /// Provides read-only access to the current status of the form.
  ///
  /// Use this getter to check the current form state and
  /// adjust UI or business logic accordingly.
  ///
  /// Example:
  /// ```dart
  /// switch(form.status) {
  ///   FFormStatus.initial => print('initial'),
  ///   FFormStatus.loading => print('loading'),
  ///   FFormStatus.success => print('success'),
  ///   FFormStatus.exception => print('exception'),
  /// };
  /// ```
  FFormStatus get status => _status;

  void _changeStatus(FFormStatus status) {
    _status = status;
    notifyListeners();
  }

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
    for (final field in _fields) {
      field
        ..removeListener(notifyListeners)
        ..dispose();
    }
    for (final form in _subForms) {
      form
        ..removeListener(notifyListeners)
        ..dispose();
    }
    super.dispose();
  }

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
    _fields.add(field);
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
    _fields.remove(field);
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
    _subForms.add(form);
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
    _subForms.remove(form);
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
    _changeStatus(FFormStatus.loading);
    await Future.forEach(_allFields, (fields) => fields.check());
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
    _changeStatus(FFormStatus.loading);
    Future.wait([for (final element in _allFields) element.check()]);
    return _check();
  }

  bool _check() {
    observer?.check(this);
    _hasCheck = true;
    _changeStatus(isValid ? FFormStatus.success : FFormStatus.exception);
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
      _fields.whereType<T>().cast<T>().first;

  List<FFormField<_NullObject, _NullObject>> get _allFields =>
      [..._fields, ..._subFormFields];

  List<FFormField<_NullObject, _NullObject>> get _subFormFields =>
      [for (final subForm in _subForms) ...subForm.fields];

  /// {@template answer_fields_property}
  /// A list of exceptions (answers) from the fields in this form.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.answerFields;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  Iterable<_NullObject> get answerFields => _fields.map((e) => e.exception);

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
        for (final subForm in _subForms) ...subForm.answerFields,
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
  Iterable<_NullObject> get exceptionFields => answerFields.nonNulls;

  /// {@template exception_subforms_property}
  /// A list of non-null exceptions from the fields in the subforms.
  ///
  /// ### Example
  /// ```dart
  /// final exceptions = form.exceptionSubForms;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  Iterable<_NullObject> get exceptionSubForms => answersSubForms.nonNulls;

  /// {@template exceptions_property}
  /// A combined list of all non-null exceptions from the fields and subforms.
  ///
  /// ### Example
  /// ```dart
  /// final allExceptions = form.exceptions;
  /// ```
  /// {@endtemplate}
  @nonVirtual
  Iterable<_NullObject> get exceptions => answers.nonNulls;

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
        true,
        (previousValue, field) => previousValue && field.isValid,
      );

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
