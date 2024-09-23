import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam.model.g.dart';

@JsonSerializable(createToJson: false)
class ExamModel extends Equatable {
  const ExamModel({
    required this.id,
    required this.questions,
    required this.title,
    required this.time,
    required this.year,
  });

  @JsonKey(name: '_id')
  final String? id;
  final int? questions;
  final String? title;
  final num? time;
  final num? year;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
