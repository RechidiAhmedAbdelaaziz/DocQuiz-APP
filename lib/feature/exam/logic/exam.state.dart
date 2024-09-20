part of 'exam.cubit.dart';

class ExamState extends ErrorState {
  ExamState({
    required this.exams,
    String? error,
  }) : super(error);

  final List<ExamModel> exams;

  factory ExamState.initial() => ExamState(exams: []);

  ExamState _fetchExams(List<ExamModel> exams) =>
      _copyWith(exams: exams);

  ExamState _errorOccured(String error) => _copyWith(error: error);

  ExamState _copyWith({
    List<ExamModel>? exams,
    String? error,
  }) {
    return ExamState(
      exams: exams ?? this.exams,
      error: error,
    );
  }
}
