part of 'dashboard.cubit.dart';

class DashboardState {
  final StatisticsModel? statistics;
  final ApiErrorModel? _error;

  DashboardState({
    this.statistics,
    ApiErrorModel? error,
  }) : _error = error;

  factory DashboardState.initial() => DashboardState();

  DashboardState _statisticsFetched(StatisticsModel statistics) =>
      _copyWith(statistics: statistics);

  DashboardState _errorOccurred(ApiErrorModel error) =>
      _copyWith(error: error);

  DashboardState _copyWith({
    StatisticsModel? statistics,
    ApiErrorModel? error,
  }) {
    return DashboardState(
      statistics: statistics ?? this.statistics,
      error: error ?? _error,
    );
  }

  void onError({required Function(ApiErrorModel) onError}) {
    if (_error != null) onError(_error);
  }
}
