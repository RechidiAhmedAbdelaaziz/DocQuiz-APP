import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.model.g.dart';

@JsonSerializable(createToJson: false)
class QuizModel extends Equatable {
  const QuizModel({
    required this.id,
    required this.totalQuestions,
    required this.result,
    required this.isCompleted,
    required this.lastAnsweredIndex,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: '_id')
  final String? id;
  final num? totalQuestions;
  final QuizResult? result;
  final bool? isCompleted;
  final num? lastAnsweredIndex;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable(createToJson: false)
class QuizResult {
  const QuizResult({
    required this.time,
    required this.answered,
    required this.correct,
    required this.correctTime,
  });

  final num? time;
  final num? answered;
  final num? correct;
  final num? correctTime;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
