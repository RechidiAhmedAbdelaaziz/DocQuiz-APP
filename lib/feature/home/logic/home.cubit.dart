import 'package:app/core/router/routebase.dart';
import 'package:app/feature/dashboard/helper/dashboard.route.dart';
import 'package:app/feature/exam/helper/exam.route.dart';
import 'package:app/feature/playlist/helper/playlist.route.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/helper/quiz.route.dart';
import 'package:app/feature/quizresult/helper/quiz_result.route.dart';
import 'package:app/feature/user/helper/user.route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(_Dashboard());

  void showDashboard() => _goTo(() => _Dashboard());
  void showMyQuiz() => _goTo(() => _MyQuiz());
  void showCreateQuiz() => _goTo(() => _CreateQuiz());
  void showPlayList() => _goTo(() => _PlayList());
  void showExam() => _goTo(() => _Exam());
  void showProfile() => _goTo(() => _Profile());
  void showQuizResult(QuizModel quiz) =>
      _goTo(() => _QuizResult.quiz(quiz));
  void showQuestionsResult(
    String title,
    List<QuestionResultModel?> questions, {
    int? totalTemps,
  }) =>
      _goTo(
          () => _QuizResult.questions(title, questions, totalTemps));

  void refresh() {
    emit(_Loading());
    Future.delayed(const Duration(milliseconds: 200), () {
      final last = state.previous;
      state.previous;
      switch (last.runtimeType) {
        case const (_Dashboard):
          emit(_Dashboard());
          break;
        case const (_MyQuiz):
          emit(_MyQuiz());
          break;
        case const (_CreateQuiz):
          emit(_CreateQuiz());
          break;
        case const (_PlayList):
          emit(_PlayList());
          break;
        case const (_Exam):
          emit(_Exam());
          break;
        case const (_Profile):
          emit(_Profile());
          break;
        default:
          if (last != null) emit(last);
      }
    });
  }

  void back() {
    final last = state.previous;
    if (last != null) emit(last);
  }

  void _goTo<T extends HomeState>(T Function() newState,
      {bool refresh = false}) {
    if (state.runtimeType == T) return;

    print("${state.runtimeType} => ${newState.runtimeType}");
    print("isEquals: ${state.runtimeType == newState.runtimeType}");
    emit(newState());
  }
}
