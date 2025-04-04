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
  final int? time;
  final num? year;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  @override
  List<Object?> get props => [id];
}



class ExamRecordModel {
  const ExamRecordModel({required this.years});

  final List<int> years;

  factory ExamRecordModel.fromJson(Map<String, dynamic> json) {
    return ExamRecordModel(
      years: List<int>.from(json['years']),
    );
  }
}
