extension ListMapWithIndex<T> on List<T> {
  List<E> mapWithIndex<E>(E Function(T element, int index) f) {
    return asMap()
        .map((index, element) => MapEntry(index, f(element, index)))
        .values
        .toList();
  }
}
