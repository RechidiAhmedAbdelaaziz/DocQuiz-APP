part of 'updtes.cubit.dart';

class UpdatesState {
  final List<UpdatesModel> updates;
  final String? _error;

  UpdatesState({
    required this.updates,
    String? error,
  }) : _error = error;

  factory UpdatesState.initial() => UpdatesState(updates: []);

  UpdatesState _fetchUpdates(List<UpdatesModel> updates) {
    return copyWith(updates: updates);
  }

  UpdatesState _setError(String error) {
    return copyWith(error: error);
  }

  UpdatesState copyWith({
    List<UpdatesModel>? updates,
    String? error,
  }) {
    return UpdatesState(
      updates: updates ?? this.updates,
      error: error,
    );
  }

  void onError(Function(String) onError) {
    if (_error != null) onError(_error);
  }
}
