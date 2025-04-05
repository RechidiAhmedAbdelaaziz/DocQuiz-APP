extension UniqList<T> on List<T> {
  void addUniq(T value) {
    if (!contains(value)) add(value);
  }

  void addAllUniq(List<T> values) {
    for (var value in values) {
      addUniq(value);
    }
  }

  bool equals(List<T> other) {
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (!contains(other[i])) return false;
    }

    return true;
  }

  void addFirst(T item) => insert(0, item);

  void addUnique(T item) {
    if (!contains(item)) add(item);
  }

  void addUniqueFirst(T item) {
    if (!contains(item)) addFirst(item);
  }

  List<T> withUnique(T item) {
    addUnique(item);
    return List.from(this);
  }

  void addAllUnique(List<T> items) => items.forEach(addUnique);

  List<T> withAllUnique(List<T> items) {
    items.forEach(addUnique);
    return List.from(this);
  }

  void replace(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return;
    this[index] = item;
  }

  List<T> withReplace(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return this;
    this[index] = item;
    return List<T>.from(this);
  }

  List<T> without(T item) {
    final index = indexWhere((e) => e == item);
    if (index == -1) return this;
    removeAt(index);
    return List<T>.from(this);
  }

  void addUniqe(T value) {
    if (!contains(value)) add(value);
  }

  void addAllUniqe(List<T> values) {
    for (var value in values) {
      addUniqe(value);
    }
  }

  void addOrRemove(T value) =>
      contains(value) ? remove(value) : add(value);

  void addOrRemoveAll(List<T> values) {
    for (var value in values) {
      addOrRemove(value);
    }
  }

  bool containsAll(List<T> values) {
    for (var value in values) {
      if (!contains(value)) return false;
    }
    return true;
  }

  //shared items
  List<T> sharedItems(List<T> items) {
    final sharedItems = <T>[];
    for (var item in items) {
      if (contains(item)) sharedItems.add(item);
    }
    return sharedItems;
  }

  //non shared items
  List<T> nonSharedItems(List<T> items) {
    final nonSharedItems = <T>[];
    for (var item in items) {
      if (!contains(item)) nonSharedItems.add(item);
    }
    return nonSharedItems;
  }
}
