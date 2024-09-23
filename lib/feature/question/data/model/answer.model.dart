// ignore_for_file: library_private_types_in_public_api

part of 'question.model.dart';

class QuestionResultModel extends Equatable {
  QuestionResultModel({
    required this.result,
    required this.question,
    List<String>? choices,
  }) : choices = choices ??
            ([...question.correctAnswers!, ...question.wrongAnswers!]
              ..shuffle());

  final List<String> choices;

  final _Result? result;
  final _QuestionModel question;

  factory QuestionResultModel.fromJson(
    Map<String, dynamic> questionJson, {
    Map<String, dynamic>? resultJson,
  }) =>
      QuestionResultModel(
        result: _Result.fromJson(resultJson ?? {}),
        question: _QuestionModel.fromJson(questionJson),
      );

  QuestionResultModel answerWith(
    List<String> choices,
  ) {
    final result = this.result?.copyWith(
              choices: choices,
              isAnswerd: true,
              isCorrect: choices.equals(question.correctAnswers!),
            ) ??
        _Result(
          choices: choices,
          isAnswerd: true,
          isCorrect: choices.equals(question.correctAnswers!),
        );

    return QuestionResultModel(
      result: result,
      question: question,
      choices: this.choices,
    );
  }

  @override
  List<Object?> get props => [question];
}

class _Result {
  const _Result({
    required this.choices,
    required this.isAnswerd,
    required this.isCorrect,
  });

  final List<String>? choices;
  final bool? isAnswerd;
  final bool? isCorrect;

  factory _Result.fromJson(Map<String, dynamic> json) => _Result(
        choices: json['choices'] != null
            ? List.from(json['choices'])
            : null,
        isAnswerd: json['isAnswerd'],
        isCorrect: json['isCorrect'],
      );

  _Result copyWith({
    List<String>? choices,
    bool? isAnswerd,
    bool? isCorrect,
  }) {
    return _Result(
      choices: choices ?? this.choices,
      isAnswerd: isAnswerd ?? this.isAnswerd,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
