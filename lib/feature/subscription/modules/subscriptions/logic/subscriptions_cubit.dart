import 'package:app/core/di/container.dart';
import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination_dto.dart';
import 'package:app/core/types/cubit_error_state.dart';
import 'package:app/feature/subscription/data/models/subscription_model.dart';
import 'package:app/feature/subscription/data/repository/subscription_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final _repo = locator<SubscriptionRepo>();
  final _pagination = PaginationDto();

  SubscriptionsCubit() : super(SubscriptionsState.initial());

  List<SubscriptionModel> get subscriptions => state._subscriptions;

  bool get isLoading => state._isLoading;

  void getSubscriptions() async {
    emit(state._loading());

    final result = await _repo.getSubscriptions(_pagination);

    result.when(
      success: (subscriptions) {
        if (subscriptions.isNotEmpty) _pagination.nextPage();
        emit(state._loaded(subscriptions));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void addSubscription(SubscriptionModel subscription) {
    emit(state._loading());
    emit(state._added(subscription));
  }

  void deleteSubscription(SubscriptionModel subscription) async {
    emit(state._loading());

    final result = await _repo.deleteSubscription(subscription);

    result.when(
      success: (_) => emit(state._deleted(subscription)),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
