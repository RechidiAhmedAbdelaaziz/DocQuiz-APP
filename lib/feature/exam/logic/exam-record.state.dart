part of 'exam-record.cubit.dart';

class ExamRecordState {
  final List<int> years;

  ExamRecordState({
    List<int>? years,
  }) : years = years ?? [];

  ExamRecordState copyWith({
    List<int>? years,
  }) {
    return ExamRecordState(
      years: years ?? this.years,
    );
  }
}
