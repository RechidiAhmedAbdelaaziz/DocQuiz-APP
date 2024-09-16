import 'package:app/core/types/di_function.dart';
import 'package:app/feature/quiz/data/source/quiz.api.dart';

import '../data/repo/quiz.repo.dart';

DependencyFunction setupQuizDependency = (container) async {
  container.registerLazySingleton(() => QuizApi(container()));
  container.registerLazySingleton<QuizRepo>(() => QuizRepo());
};
