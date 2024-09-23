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

  //equals
  bool equals(List<T> items) {
    return containsAll(items) && items.containsAll(this);
  }


  
}
