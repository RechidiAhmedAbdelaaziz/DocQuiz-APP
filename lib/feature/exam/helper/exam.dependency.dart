import 'package:app/feature/exam/data/repo/exam.repo.dart';
import 'package:app/feature/exam/data/source/exam.api.dart';
import 'package:get_it/get_it.dart';

Future<void> setupExamDependency(GetIt sl) async {
  sl.registerLazySingleton(() => ExamApi(sl()));
  sl.registerLazySingleton(() => ExamRepo());
}
