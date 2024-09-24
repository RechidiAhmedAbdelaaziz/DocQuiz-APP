import 'package:app/feature/notes/data/repo/notes.repo.dart';
import 'package:app/feature/notes/data/source/notes.api.dart';
import 'package:get_it/get_it.dart';

Future<void> setupNoteDependencies(GetIt locator) async {
  locator.registerLazySingleton(() => NotesApi(locator()));

  locator.registerLazySingleton(() => NotesRepo());
}
