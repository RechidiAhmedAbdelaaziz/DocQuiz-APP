import 'package:app/core/extension/list.extension.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.model.g.dart';
part 'answer.model.dart';

@JsonSerializable(createToJson: false)
class QuestionModel extends Equatable {
  const QuestionModel({
    required this.id,
    required this.caseText,
    required this.questions,
    required this.type,
    required this.exam,
    required this.course,
    required this.sources,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? caseText;
  final List<Question>? questions;
  final String? type;
  final ExamModel? exam;
  final CourseModel? course;
  final List<SourceYear>? sources;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable(createToJson: false)
class Question extends Equatable {
  const Question({
    required this.text,
    required this.answers,
    required this.difficulty,
    required this.type,
    required this.explanation,
  });

  final String? text;
  final List<Answer> answers;
  final String? difficulty;
  final String? type;
  final String? explanation;

  List<int> get correctChoices => answers
      .where((e) => e.isCorrect == true)
      .map((e) => answers.indexOf(e))
      .toList();

  bool get isMultiple => type == 'QCM';

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  @override
  List<Object?> get props => [text];
}

@JsonSerializable(createToJson: false)
class Answer extends Equatable {
  const Answer({
    required this.text,
    required this.isCorrect,
  });

  final String? text;
  final bool? isCorrect;

  factory Answer.fromJson(Map<String, dynamic> json) =>
      _$AnswerFromJson(json);

  @override
  List<Object?> get props => [text];
}


@JsonSerializable(createToJson: false)
class SourceYear extends Equatable {
  const SourceYear({
    required this.source,
    required this.year,
  });

  final SourceModel? source;
  final int? year;

  factory SourceYear.fromJson(Map<String, dynamic> json) =>
      _$SourceYearFromJson(json);

  @override
  List<Object?> get props => [source];
}