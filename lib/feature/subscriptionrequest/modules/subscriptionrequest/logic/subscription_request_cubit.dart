import 'package:app/core/di/container.dart';
import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination_dto.dart';
import 'package:app/core/types/cubit_error_state.dart';
import 'package:app/feature/subscriptionrequest/data/models/subscription_request_model.dart';
import 'package:app/feature/subscriptionrequest/data/repo/subscription_request_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subscription_request_state.dart';

class SubscriptionRequestCubit
    extends Cubit<SubscriptionRequestState> {
  final _repo = locator<SubscriptionRequestRepo>();
  final _paginationDto = PaginationDto();

  SubscriptionRequestCubit()
      : super(SubscriptionRequestState.initial());

  List<SubscriptionRequestModel> get requests => state._requests;

  void loadRequests() async {
    if (state.isLoading) return;

    emit(state._loadign());

    final result = await _repo.getSubscriptionRequests(
      _paginationDto,
    );

    result.when(
      success: (requests) {
        if (requests.isNotEmpty) _paginationDto.nextPage();

        emit(state._loaded(requests));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void approveRequest(
    SubscriptionRequestModel request,
  ) async {
    if (state.isLoading) return;

    emit(state._loadign());

    final result = await _repo.approveSubscriptionRequest(request);

    result.when(
      success: (_) => emit(state._removed(request)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void rejectRequest(
    SubscriptionRequestModel request,
  ) async {
    if (state.isLoading) return;

    emit(state._loadign());

    final result = await _repo.deleteSubscriptionRequest(request);

    result.when(
      success: (_) => emit(state._removed(request)),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
