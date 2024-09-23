import 'package:app/core/extension/list.extension.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.model.g.dart';
part 'answer.model.dart';

@JsonSerializable(createToJson: false)
class _QuestionModel extends Equatable {
  const _QuestionModel({
    required this.id,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.questionText,
    required this.difficulty,
    required this.type,
    required this.course,
    required this.explanation,
    required this.source,
    required this.year,
    required this.exam,
  });

  @JsonKey(name: '_id')
  final String? id;
  final List<String>? correctAnswers;
  final List<String>? wrongAnswers;
  final String? questionText;
  final String? difficulty;
  final String? type;
  final CourseModel? course;
  final String? explanation;
  final SourceModel? source;
  final ExamModel? exam;
  final num? year;

  

  factory _QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
