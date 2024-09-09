import 'package:app/core/network/models/api_error.model.dart';

class ErrorState {
  final ApiErrorModel? _error;

  ErrorState(this._error);

  void onError({required Function(String message) onError}) {
    if (_error != null) onError(_error.message);
  }
}
