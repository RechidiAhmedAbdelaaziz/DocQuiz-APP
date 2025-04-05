part of 'subscription_request_cubit.dart';

enum _SubscriptionRequestStatus {
  initial,
  loading,
  loaded,
  error,
}

class SubscriptionRequestState extends CubitErrorState {
  final List<SubscriptionRequestModel> _requests;
  final _SubscriptionRequestStatus _status;

  SubscriptionRequestState({
    List<SubscriptionRequestModel> requests = const [],
    _SubscriptionRequestStatus? status,
    String? error,
  })  : _requests = requests,
        _status = status ?? _SubscriptionRequestStatus.initial,
        super(error);

  factory SubscriptionRequestState.initial() =>
      SubscriptionRequestState();

  bool get isLoading => _status == _SubscriptionRequestStatus.loading;

  SubscriptionRequestState _loadign() => _copyWith(
        status: _SubscriptionRequestStatus.loading,
      );

  SubscriptionRequestState _loaded(
          List<SubscriptionRequestModel> requests) =>
      _copyWith(
        requests: List<SubscriptionRequestModel>.from(_requests)
            .withAllUnique(requests),
        status: _SubscriptionRequestStatus.loaded,
      );

  SubscriptionRequestState _removed(
          SubscriptionRequestModel request) =>
      _copyWith(
        requests: List<SubscriptionRequestModel>.from(_requests)
            .without(request),
        status: _SubscriptionRequestStatus.loaded,
      );

  SubscriptionRequestState _error(String error) => _copyWith(
        error: error,
        status: _SubscriptionRequestStatus.error,
      );

  SubscriptionRequestState _copyWith({
    List<SubscriptionRequestModel>? requests,
    _SubscriptionRequestStatus? status,
    String? error,
  }) =>
      SubscriptionRequestState(
        requests: requests ?? _requests,
        status: status ?? _status,
        error: error,
      );

  @override
  List<Object?> get props => [
        _requests,
        _status,
      ];
}
