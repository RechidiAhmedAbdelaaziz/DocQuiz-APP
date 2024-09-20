part of 'names.cubit.dart';

class NamesState<T extends NamedModel> extends ErrorState {
  NamesState({
    List<T>? items,
    String? error,
  })  : items = items ?? [],
        super(error);

  final List<T> items;

  factory NamesState.initial() => NamesState();

  NamesState<T> fetchLevels(List<T> items) {
    return __copyWith(items: items);
  }

  NamesState<T> errorOccurred(String error) {
    return __copyWith(error: error);
  }

  NamesState<T> __copyWith({
    List<T>? items,
    String? error,
  }) {
    return NamesState(items: items ?? this.items, error: error);
  }
}
