import 'package:json_annotation/json_annotation.dart';

part 'update_quiz.dto.g.dart';

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

  Map<String, dynamic> toJson() =>
    <String, dynamic>{
      'title': title,
      'isCompleted': isCompleted,
      'questionAnswer': questionAnswer?.toJson(),
      'lastAnsweredIndex': lastAnsweredIndex,
    };
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
  final List<bool>? isCorrect;
  final List<List<int>>? choices;
  final num? time;

  Map<String, dynamic> toJson() => _$QuestionAnswerToJson(this);
}
