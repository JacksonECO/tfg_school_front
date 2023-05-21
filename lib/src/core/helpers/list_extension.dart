extension ListExtension<T> on List<T> {
  T? index(int index) {
    if (length <= index) {
      return null;
    }
    return this[index];
  }
}
