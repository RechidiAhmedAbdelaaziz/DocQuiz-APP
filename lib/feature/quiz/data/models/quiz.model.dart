import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.model.g.dart';

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
    required this.coerrectIndexes,
    required this.wrongIndexes,
  });

  @JsonKey(name: '_id')
  final String? id;
  final int? totalQuestions;
  final QuizResult? result;
  final bool? isCompleted;
  final int? lastAnsweredIndex;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<int> coerrectIndexes;
  final Map<int, List<int>> wrongIndexes;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json['_id'] as String?,
        totalQuestions: (json['totalQuestions'] as num?)?.toInt(),
        result: json['result'] == null
            ? null
            : QuizResult.fromJson(
                json['result'] as Map<String, dynamic>),
        isCompleted: json['isCompleted'] as bool?,
        lastAnsweredIndex:
            (json['lastAnsweredIndex'] as num?)?.toInt(),
        title: json['title'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        coerrectIndexes: (json['coerrectIndexes'] as List<dynamic>)
            .map((e) => (e as num).toInt())
            .toList(),
        // "wrongIndexes": [{questionIndex: 0, subQuestionIndexes: [0]}]
        wrongIndexes: (json['wrongIndexes'] as List<dynamic>) // 1
            .map(
          (e) => (e as Map<String, dynamic>).map(
            (_, __) => MapEntry(
              e['questionIndex'] as int,
              (e['subQuestionIndexes'] as List<dynamic>)
                  .map((e) => (e as num).toInt())
                  .toList(),
            ),
          ),
        )
            .fold<Map<int, List<int>>>({}, (previousValue, element) {
          previousValue.addAll(element);
          return previousValue;
        }),
      );

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
