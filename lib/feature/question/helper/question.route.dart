import 'package:app/core/di/container.dart';
import 'package:app/core/router/abstract_route.dart';
import 'package:app/core/shared/widgets/timer.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:app/feature/question/data/repo/question.repo.dart';
import 'package:app/feature/question/logic/questions.cubit.dart';
import 'package:app/feature/question/ui/question.screen.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionRoute extends RouteBase {
  static const String examQuesion = '/exam-question';

  QuestionRoute.exam(ExamModel exam)
      : super(
          examQuesion,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimeCubit(time: exam.time!),
              ),
              BlocProvider(
                create: (context) => QuestionCubit(
                  exam.questions!,
                  (query) {
                    return locator<QuestionRepo>()
                        .getExamQuestions(exam.id!, query: query);
                  },
                  timeCubit: context.read<TimeCubit>(),
                )..fetchQuestions(),
              ),
            ],
            child: QuestionScreen(title: exam.title!),
          ),
        );

  static const String quizQuestion = '/quiz-question';

  QuestionRoute.quiz(QuizModel quiz)
      : super(
          quizQuestion,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimeCubit(),
              ),
              BlocProvider(
                create: (context) => QuestionCubit(
                  quiz.totalQuestions!,
                  (query) {
                    return locator<QuestionRepo>()
                        .getQuizQuestions(quiz.id!, query: query);
                  },
                  timeCubit: context.read<TimeCubit>(),
                  // TODO add on answered
                )..fetchQuestions(),
              ),
            ],
            child: QuestionScreen(title: quiz.title!),
          ),
        );
}
