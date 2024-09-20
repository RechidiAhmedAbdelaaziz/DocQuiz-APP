
class ErrorState {
  final String? _error;

  ErrorState(this._error);

  void onError(Function(String message) onError) {
    if (_error != null) onError(_error);
  }
}
