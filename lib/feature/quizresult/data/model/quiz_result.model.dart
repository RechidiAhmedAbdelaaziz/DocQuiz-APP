import 'dart:math';

import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';

class QuizResultModel {
  final String title;
  final int totalQuestions;
  final int correctAnswers;
  final int unAnswered;
  final int time;
  final int correctTime;

  int get wrongAnswers =>
      totalQuestions - unAnswered - correctAnswers;

  const QuizResultModel({
    required this.title,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.unAnswered,
    required this.time,
    required this.correctTime,
  });

  factory QuizResultModel.fromQuiz(QuizModel quiz) {
    return QuizResultModel(
      title: quiz.title!,
      totalQuestions: quiz.totalQuestions!,
      correctAnswers: quiz.result?.correct as int? ?? 0,
      unAnswered: (quiz.totalQuestions! -
          (quiz.result?.answered as int? ?? 0)),
      time: quiz.result?.time as int? ?? 0,
      correctTime: quiz.result?.correctTime as int? ?? 0,
    );
  }

  factory QuizResultModel.fromQuestionsList(
      String title, List<QuestionResultModel?> questions,
      {int? totalTemps}) {
    final results = questions.map((e) => e?.result).toList();

    final correctAnswers =
        results.where((e) => e?.isAllCorrect == true).length;

    final nonAnswered =
        results.where((e) => e?.isAnswerd != true).length;

    final time = totalTemps != null
        ? totalTemps - results.map((e) => e?.time ?? 0).reduce(max)
        : results.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element?.time ?? 0),
          );

    final correctTime = results.fold<int>(
      0,
      (previousValue, element) =>
          previousValue +
          (element?.isAllCorrect == true ? element?.time ?? 0 : 0),
    );

    return QuizResultModel(
      title: title,
      totalQuestions: questions.length,
      correctAnswers: correctAnswers,
      unAnswered: nonAnswered,
      time: time,
      correctTime: correctTime,
    );
  }
}
