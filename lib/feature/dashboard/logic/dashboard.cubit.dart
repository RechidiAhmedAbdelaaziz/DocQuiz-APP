import 'package:app/core/di/container.dart';
import 'package:app/core/network/models/api_error.model.dart';
import 'package:app/feature/dashboard/data/models/statistics.model.dart';
import 'package:app/feature/dashboard/data/repo/dashboard.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard.state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final _dashboardRepo = locator<DashboardRepo>();

  DashboardCubit() : super(DashboardState.initial()) {
    getDashboard();
  }

  Future<void> getDashboard() async {
    final result = await _dashboardRepo.getDashboard();
    result.when(
      success: (statistics) =>
          emit(state._statisticsFetched(statistics)),
      error: (error) => emit(state._errorOccurred(error)),
    );
  }
}
