part of 'subscriptions_cubit.dart';

enum _SubscriptionsStatus {
  initial,
  loading,
  loaded,
  error,
}

class SubscriptionsState extends CubitErrorState {
  final List<SubscriptionModel> _subscriptions;
  final _SubscriptionsStatus _status;

  const SubscriptionsState({
    List<SubscriptionModel> subscriptions = const [],
    _SubscriptionsStatus status = _SubscriptionsStatus.initial,
    String? error,
  })  : _subscriptions = subscriptions,
        _status = status,
        super(error);

  factory SubscriptionsState.initial() => SubscriptionsState();

  bool get _isLoading => _status == _SubscriptionsStatus.loading;

  SubscriptionsState _copyWith({
    List<SubscriptionModel>? subscriptions,
    _SubscriptionsStatus? status,
    String? error,
  }) {
    return SubscriptionsState(
      subscriptions: subscriptions ?? _subscriptions,
      status: status ?? _status,
      error: error,
    );
  }

  SubscriptionsState _loading() =>
      _copyWith(status: _SubscriptionsStatus.loading);

  SubscriptionsState _loaded(List<SubscriptionModel> subscriptions) =>
      _copyWith(
        subscriptions: List<SubscriptionModel>.from(_subscriptions)
            .withAllUnique(subscriptions),
        status: _SubscriptionsStatus.loaded,
      );

  SubscriptionsState _added(SubscriptionModel subscription) =>
      _copyWith(
        subscriptions: List<SubscriptionModel>.from(_subscriptions)
            .withUnique(subscription),
        status: _SubscriptionsStatus.loaded,
      );

  SubscriptionsState _deleted(SubscriptionModel subscription) =>
      _copyWith(
        subscriptions: List<SubscriptionModel>.from(_subscriptions)
            .without(subscription),
        status: _SubscriptionsStatus.loaded,
      );

  SubscriptionsState _error(String error) => _copyWith(
        status: _SubscriptionsStatus.error,
        error: error,
      );

  @override
  List<Object?> get props => [_subscriptions, _status];
}
