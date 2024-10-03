
import 'package:app/feature/updates/data/repo/updates.repo.dart';
import 'package:app/feature/updates/data/source/updates.api.dart';
import 'package:get_it/get_it.dart';

Future<void> setupUpdatesDi(GetIt locator) async {
  locator
      .registerLazySingleton<UpdatesApi>(() => UpdatesApi(locator()));
  locator.registerLazySingleton<UpdatesRepo>(() => UpdatesRepo());
}
