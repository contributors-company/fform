part of 'fform.dart';

/// FFormFieldListener is a function that takes a FFormFieldResponse as a parameter.
typedef FFormFieldListener<T, E> = void Function(
    FFormFieldResponse<T, E> value);

/// FFormFieldResponse is a class that holds the value of the field and the exception of the field.
class FFormFieldResponse<T, E> {
  final T value;
  final E? exception;

  FFormFieldResponse(this.value, this.exception);
}

/// FFormListener is a function that takes a FForm as a parameter.
typedef FFormListener<T extends FForm> = void Function();
