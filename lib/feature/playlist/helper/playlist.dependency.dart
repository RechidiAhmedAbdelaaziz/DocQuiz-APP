import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/repo/playlist.repo.dart';
import '../data/source/playlist.api.dart';

Future<void> setupPlaylistDependency(GetIt locator) async {
  locator.registerLazySingleton(() => PlaylistApi(locator<Dio>()));

  locator.registerLazySingleton(() => PlaylistRepo());
}
