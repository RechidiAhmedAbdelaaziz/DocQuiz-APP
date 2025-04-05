// ignore_for_file: library_private_types_in_public_api

part of 'multi_subscription_offer_cubit.dart';

enum _MultiSubscriptionOfferStatus {
  initial,
  loading,
  loaded,
  error,
}

class MultiSubscriptionOfferState {
  final List<SubscriptionOfferModel> offers;
  final _MultiSubscriptionOfferStatus _status;

  MultiSubscriptionOfferState({
    this.offers = const [],
    _MultiSubscriptionOfferStatus? status,
  }) : _status = status ?? _MultiSubscriptionOfferStatus.initial;

  factory MultiSubscriptionOfferState.initial() =>
      MultiSubscriptionOfferState();

  bool get isLoading =>
      _status == _MultiSubscriptionOfferStatus.loading;

  MultiSubscriptionOfferState _loadign() => _copyWith(
        status: _MultiSubscriptionOfferStatus.loading,
      );

  MultiSubscriptionOfferState _loaded(
          List<SubscriptionOfferModel> offers) =>
      _copyWith(
        offers: List<SubscriptionOfferModel>.from(this.offers)
            .withAllUnique(offers),
        status: _MultiSubscriptionOfferStatus.loaded,
      );

  MultiSubscriptionOfferState _created(
          SubscriptionOfferModel offer) =>
      _copyWith(
        offers: List<SubscriptionOfferModel>.from(offers)
            .withUnique(offer),
        status: _MultiSubscriptionOfferStatus.loaded,
      );

  MultiSubscriptionOfferState _updated(
          SubscriptionOfferModel offer) =>
      _copyWith(
        offers: List<SubscriptionOfferModel>.from(offers)
            .withReplace(offer),
        status: _MultiSubscriptionOfferStatus.loaded,
      );

  MultiSubscriptionOfferState _deleted(
          SubscriptionOfferModel offer) =>
      _copyWith(
        offers:
            List<SubscriptionOfferModel>.from(offers).without(offer),
        status: _MultiSubscriptionOfferStatus.loaded,
      );

  MultiSubscriptionOfferState _error(String error) => _copyWith(
        status: _MultiSubscriptionOfferStatus.error,
      );

  MultiSubscriptionOfferState _copyWith({
    List<SubscriptionOfferModel>? offers,
    _MultiSubscriptionOfferStatus? status,
  }) {
    return MultiSubscriptionOfferState(
      offers: offers ?? this.offers,
      status: status ?? _status,
    );
  }
}
