import 'package:app/core/types/di_function.dart';
import 'package:app/feature/dashboard/data/repo/dashboard.repo.dart';
import 'package:app/feature/dashboard/data/source/dashboard.api.dart';

DependencyFunction setupDashboardDependency = (locator) async {
  locator.registerLazySingleton(() => DashboardApi(locator()));
  locator.registerLazySingleton(() => DashboardRepo());
};
