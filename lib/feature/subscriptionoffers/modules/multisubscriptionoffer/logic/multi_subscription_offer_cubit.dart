import 'package:app/core/di/container.dart';
import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination_dto.dart';
import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
import 'package:app/feature/subscriptionoffers/data/repository/subscription_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'multi_subscription_offer_state.dart';

class MultiSubscriptionOfferCubit
    extends Cubit<MultiSubscriptionOfferState> {
  final _repository = locator<SubscriptionOfferRepo>();
  final _pagination = PaginationDto();

  List<SubscriptionOfferModel> get offers => state.offers;

  MultiSubscriptionOfferCubit()
      : super(MultiSubscriptionOfferState.initial());

  void loadOffers() async {
    if (state.isLoading) return;
    emit(state._loadign());
    final result =
        await _repository.getSubscriptionOffers(_pagination);

    result.when(
        success: (offers) {
          if (offers.isNotEmpty) _pagination.nextPage();
          emit(state._loaded(offers));
        },
        error: (error) => emit(state._error(error.message)));
  }

  void createOffer(SubscriptionOfferModel offer) =>
      emit(state._created(offer));

  void updateOffer(SubscriptionOfferModel offer) =>
      emit(state._updated(offer));

  void deleteOffer(SubscriptionOfferModel offer) async {
    if (state.isLoading) return;
    emit(state._loadign());
    final result = await _repository.deleteSubscriptionOffer(offer);

    result.when(
        success: (_) => emit(state._deleted(offer)),
        error: (error) => emit(state._error(error.message)));
  }
}
