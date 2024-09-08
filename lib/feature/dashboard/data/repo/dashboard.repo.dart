import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/dashboard/data/source/dashboard.api.dart';

import '../models/statistics.model.dart';

class DashboardRepo {
  final _api = locator<DashboardApi>();

  RepoResult<StatisticsModel> getDashboard() async {
    apiCall() async {
      final response = await _api.getDashboard();
      return StatisticsModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }
}
