// ignore_for_file: library_private_types_in_public_api

part of 'question.model.dart';

class QuestionResultModel extends Equatable {
  QuestionResultModel({
    _Result? result,
    required this.question,
    List<String>? choices,
  })  : choices = choices ??
            ([...question.correctAnswers!, ...question.wrongAnswers!]
              ..shuffle()),
        result = result ?? _Result();

  final List<String> choices;

  final _Result result;
  final _QuestionModel question;

  factory QuestionResultModel.fromJson(
    Map<String, dynamic> questionJson, {
    Map<String, dynamic>? resultJson,
  }) =>
      QuestionResultModel(
        result: _Result.fromJson(resultJson ?? {}),
        question: _QuestionModel.fromJson(questionJson),
      );

  QuestionResultModel saveTime(int time) {
    final result = this.result.copyWith(time: time);
    return QuestionResultModel(
      result: result,
      question: question,
      choices: choices,
    );
  }

  QuestionResultModel answerWith(List<String> choices) {
    final result = this.result.copyWith(
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
    this.choices,
    this.isAnswerd = false,
    this.isCorrect,
    this.time,
  });

  final int? time;
  final List<String>? choices;
  final bool? isAnswerd;
  final bool? isCorrect;

  factory _Result.fromJson(Map<String, dynamic> json) => _Result(
        choices: json['choices'] != null
            ? List.from(json['choices'])
            : null,
        isAnswerd: json['isAnswerd'],
        isCorrect: json['isCorrect'],
        time: json['time'],
      );

  _Result copyWith({
    List<String>? choices,
    bool? isAnswerd,
    bool? isCorrect,
    int? time,
  }) {
    return _Result(
      choices: choices ?? this.choices,
      isAnswerd: isAnswerd ?? this.isAnswerd,
      isCorrect: isCorrect ?? this.isCorrect,
      time: time ?? this.time,
    );
  }
}
