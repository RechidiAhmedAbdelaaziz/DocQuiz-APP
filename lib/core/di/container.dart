import 'package:app/core/helper/dio.helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator({required String baseUrl}) async {
  locator.registerLazySingletonAsync(
      () async => await SharedPreferences.getInstance());

  locator.registerLazySingleton(() => const FlutterSecureStorage());

  locator.registerLazySingleton(() => DioHelper.getDio(baseUrl));
  // locator.registerLazySingleton(() => CacheHelper());
}
