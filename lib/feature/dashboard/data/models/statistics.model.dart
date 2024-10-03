import 'package:json_annotation/json_annotation.dart';

part 'statistics.model.g.dart';

@JsonSerializable(createToJson: false)
class StatisticsModel {
  StatisticsModel({
    required this.totalExam,
    required this.totalQuestion,
    required this.totalUser,
    required this.totalSubscribedUser,
    required this.totalMajor,
    required this.quizDoneToday,
    required this.totalCCQuestion,
  });

  final num? totalExam;
  final num? totalQuestion;
  final num? totalUser;
  final num? totalSubscribedUser;
  final num? totalMajor;
  final num? quizDoneToday;
  final int totalCCQuestion;

  factory StatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsModelFromJson(json);
}
