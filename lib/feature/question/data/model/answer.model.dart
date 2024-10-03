// ignore_for_file: library_private_types_in_public_api

part of 'question.model.dart';

class QuestionResultModel extends Equatable {
  const QuestionResultModel({
    required this.question,
    Result? result,
  }) : result = result ?? const Result();

  final QuestionModel question;
  final Result result;

  factory QuestionResultModel.fromJson(
    Map<String, dynamic> questionJson, {
    Map<String, dynamic>? resultJson,
  }) =>
      QuestionResultModel(
        question: QuestionModel.fromJson(questionJson),
        result:
            resultJson != null ? Result.fromJson(resultJson) : null,
      );

  bool get isCorrect => result.isCorrect.every((e) => e);

  QuestionResultModel answer(List<List<int>> choices) {
    final correctIndexs =
        question.questions!.map((e) => e.correctChoices).toList();

    List<bool> isCorrect = [];
    for (var i = 0; i < choices.length; i++) {
      isCorrect.add(choices[i].equals(correctIndexs[i]));
    }

    return _copyWith(
      result: result.copyWith(
        choices: choices,
        isAnswerd: true,
        isCorrect: isCorrect,
      ),
    );
  }

  QuestionResultModel saveTime(int time) => _copyWith(
        result: result.copyWith(time: time),
      );

  QuestionResultModel _copyWith({
    Result? result,
  }) =>
      QuestionResultModel(
        question: question,
        result: result ?? this.result,
      );

  @override
  List<Object?> get props => [question];
}

@JsonSerializable(createToJson: false)
class Result extends Equatable {
  const Result({
    this.time = 0,
    this.choices = const [],
    this.isCorrect = const [],
    this.isAnswerd = false,
  });

  final int time;
  final List<List<int>> choices;
  final List<bool> isCorrect;
  final bool isAnswerd;

  bool get isAllCorrect => isCorrect.every((e) => e);
  List<int> get correctIndexes => isCorrect
      .asMap()
      .entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Result copyWith({
    int? time,
    List<List<int>>? choices,
    List<bool>? isCorrect,
    bool? isAnswerd,
  }) =>
      Result(
        time: time ?? this.time,
        choices: choices ?? this.choices,
        isCorrect: isCorrect ?? this.isCorrect,
        isAnswerd: isAnswerd ?? this.isAnswerd,
      );

  @override
  List<Object?> get props => [choices];
}
