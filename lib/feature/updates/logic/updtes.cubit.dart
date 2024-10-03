import 'package:app/core/di/container.dart';
import 'package:app/feature/updates/data/model/updates.model.dart';
import 'package:app/feature/updates/data/repo/updates.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'updates.state.dart';

class UpdatesCubit extends Cubit<UpdatesState> {
  final _apiRepo = locator<UpdatesRepo>();
  UpdatesCubit() : super(UpdatesState.initial());

  void fetchUpdates() async {
    final result = await _apiRepo.getUpdates();
    result.when(
      success: (updates) => emit(state._fetchUpdates(updates)),
      error: (error) => emit(state._setError(error.message)),
    );
  }
}
