import 'package:json_annotation/json_annotation.dart';

part 'update_quiz.dto.g.dart';

@JsonSerializable(createFactory: false)
class UpdateQuizBody {
  UpdateQuizBody({
    this.title,
    this.isCompleted,
    this.questionAnswer,
    this.lastAnsweredIndex,
  });
  final String? title;
  final bool? isCompleted;
  final QuestionAnswer? questionAnswer;
  final num? lastAnsweredIndex;

  Map<String, dynamic> toJson() => _$UpdateQuizBodyToJson(this);
}

@JsonSerializable(createFactory: false)
class QuestionAnswer {
  QuestionAnswer({
    required this.questionId,
    required this.isCorrect,
    required this.choices,
    required this.time,
  });

  final String? questionId;
  final bool? isCorrect;
  final List<String>? choices;
  final num? time;

  Map<String, dynamic> toJson() => _$QuestionAnswerToJson(this);
}
