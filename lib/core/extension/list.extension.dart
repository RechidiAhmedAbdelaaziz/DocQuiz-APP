extension UniqList<T> on List<T> {
  void addUniq(T value) {
    if (!contains(value)) add(value);
  }

  void addAllUniq(List<T> values) {
    for (var value in values) {
      addUniq(value);
    }
  }

  void update(T value) {
    final index = indexWhere((element) => element == value);
    if (index != -1) this[index] = value;
  }
}
