import 'package:app/core/helper/cache.helper.dart';
import 'package:app/core/helper/dio.helper.dart';
import 'package:app/core/theme/colors.dart';
import 'package:app/core/theme/fonts.dart';
import 'package:app/feature/auth/helper/auth.dependency.dart';
import 'package:app/feature/dashboard/helper/dashboard.dependency.dart';
import 'package:app/feature/quiz/helper/quiz.dependency.dart';
import 'package:app/feature/themes/logic/themes.cubit.dart';
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

  locator.registerSingleton<AppColors>(LightColors());
  locator.registerSingleton(AppFontStyles());
  locator.registerSingleton(ThemesCubit());

  await setupAuthDependency(locator);
  await setupDashboardDependency(locator);
  await setupQuizDependency(locator);

  locator.allowReassignment = true;
}
