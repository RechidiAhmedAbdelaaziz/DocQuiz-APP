import 'package:app/core/types/di_function.dart';
import 'package:dio/dio.dart';

import '../data/repo/auth.repo.dart';
import '../data/source/auth.api.dart';
import '../data/source/auth.cache.dart';

DependencyFunction setupAuthDependency = (locator) async {
  locator.registerFactory(() => AuthApi(locator<Dio>()));

  locator.registerFactory<AuthCache>(() => AuthCache());

  locator.registerFactory(() => AuthRepo());
};

