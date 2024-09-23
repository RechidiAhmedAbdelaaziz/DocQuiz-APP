import 'package:app/feature/question/data/repo/question.repo.dart';
import 'package:app/feature/question/data/source/question.api.dart';
import 'package:get_it/get_it.dart';

Future<void> injectQuestionDependencies(GetIt locator) async {
  locator.registerLazySingleton(() => QuestionApi(locator()));
  locator.registerLazySingleton(() => QuestionRepo());
}
