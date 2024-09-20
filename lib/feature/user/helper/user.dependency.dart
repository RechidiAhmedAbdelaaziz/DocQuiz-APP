import 'package:app/feature/user/data/repo/user.repo.dart';
import 'package:app/feature/user/data/source/user.api.dart';
import 'package:get_it/get_it.dart';

Future<void> setupUserDependency(GetIt locator) async {
  locator.registerLazySingleton(() => UserApi(locator()));
  locator.registerLazySingleton(() => UserRepo());
}
