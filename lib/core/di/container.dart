import 'package:app/core/helper/cache.helper.dart';
import 'package:app/core/helper/dio.helper.dart';
import 'package:app/feature/auth/helper/auth.dependency.dart';
import 'package:app/feature/dashboard/helper/dashboard.dependency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator({required String baseUrl}) async {
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPref);

  locator.registerLazySingleton(() => const FlutterSecureStorage());

  locator.registerLazySingleton(() => DioHelper.getDio(baseUrl));
  locator.registerLazySingleton(() => CacheHelper());

  await setupAuthDependency(locator);
  await setupDashboardDependency(locator);
}
