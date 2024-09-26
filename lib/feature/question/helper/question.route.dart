import 'package:app/core/di/container.dart';
import 'package:app/core/router/abstract_route.dart';
import 'package:app/core/shared/widgets/timer.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/data/repo/question.repo.dart';
import 'package:app/feature/question/logic/questions.cubit.dart';
import 'package:app/feature/question/ui/question.screen.dart';
import 'package:app/feature/quiz/data/dto/update_quiz.dto.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionRoute extends RouteBase<List<QuestionResultModel?>> {
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
                  onAnswered: (question) {
                    locator<QuizRepo>().updateQuiz(
                      id: quiz.id!,
                      updates: UpdateQuizBody(
                        questionAnswer: QuestionAnswer(
                          questionId: question.question.id!,
                          isCorrect: question.result.isCorrect,
                          choices: question.result.choices,
                          time: question.result.time,
                        ),
                      ),
                    );
                  },
                )..fetchQuestions(),
              ),
            ],
            child: QuestionScreen(title: quiz.title!),
          ),
        );



  static const String playlistQuestion = '/playlist';

  QuestionRoute.playlist(PlaylistModel playlist)
      : super(
          examQuesion,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimeCubit(),
              ),
              BlocProvider(
                create: (context) => QuestionCubit(
                  playlist.totalQuestions!,
                  (query) {
                    return locator<QuestionRepo>()
                        .getPlaylistQuestions(playlist.id!, query: query);
                  },
                  timeCubit: context.read<TimeCubit>(),
                )..fetchQuestions(),
              ),
            ],
            child: QuestionScreen(title: playlist.title!),
          ),
        );
}
