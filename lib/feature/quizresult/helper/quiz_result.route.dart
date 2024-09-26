import 'package:app/core/router/routebase.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quizresult/data/model/quiz_result.model.dart';

import '../ui/result.screen.dart';

class QuizResultRoute extends DrawerRoute {
  static const route = '/quiz-result';

  QuizResultRoute.quiz(QuizModel quiz)
      : super(
          child: QuizResultScreen(
            QuizResultModel.fromQuiz(quiz),
          ),
        );

  QuizResultRoute.questions(
      String title, List<QuestionResultModel?> questions,
      {int? totalTemps})
      : super(
          child: QuizResultScreen(
            QuizResultModel.fromQuestionsList(title, questions,
                totalTemps: totalTemps),
          ),
        );
}
