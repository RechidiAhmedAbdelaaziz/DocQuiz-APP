extension UniqList<T> on List<T> {
  void addUniq(T value) {
    if (!contains(value)) add(value);
  }

  void addAllUniq(List<T> values) {
    for (var value in values) {
      addUniq(value);
    }
  }

  void addOrRemove(T value) =>
      contains(value) ? remove(value) : add(value);

  void addOrRemoveAll(List<T> values) {
    for (var value in values) {
      addOrRemove(value);
    }
  }
}
