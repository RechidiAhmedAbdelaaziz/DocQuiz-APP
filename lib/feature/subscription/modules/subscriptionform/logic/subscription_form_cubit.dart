import 'package:app/core/di/container.dart';
import 'package:app/core/types/cubit_error_state.dart';
import 'package:app/feature/subscription/data/dto/create_subscription_dto.dart';
import 'package:app/feature/subscription/data/models/subscription_model.dart';
import 'package:app/feature/subscription/data/repository/subscription_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subscription_form_state.dart';

class SubscriptionFormCubit extends Cubit<SubscriptionFormState> {
  final _repo = locator<SubscriptionRepo>();

  SubscriptionFormCubit() : super(SubscriptionFormState.initial());

  CreateSubscriptionDto get dto => state._dto;

  void createSubscription() async {
    if (state.isLoading || !dto.validate()) return;
    emit(state._loading());

    final result = await _repo.createSubscription(dto);

    result.when(
      success: (subscription) => emit(state._loaded(subscription)),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
