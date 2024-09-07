import 'package:app/core/types/di_function.dart';
import 'package:app/feature/auth/logic/auth.cubit.dart';
import 'package:dio/dio.dart';

import '../data/repo/auth.repo.dart';
import '../data/source/auth.api.dart';
import '../data/source/auth.cache.dart';

DependencyFunction setupAuthDependency = (locator) async {
  locator.registerLazySingleton(() => AuthApi(locator<Dio>()));

  locator.registerLazySingleton<AuthCache>(() => AuthCache());

  locator.registerLazySingleton(() => AuthRepo());

  locator.registerLazySingleton(() => AuthCubit());
};
