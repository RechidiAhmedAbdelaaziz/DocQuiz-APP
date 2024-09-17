part of 'create_quiz.cubit.dart';

class CreateQuizState extends ErrorState {
  CreateQuizState({
    required QuestionFilter filter,
    required this.questionNumber,
    String? error,
  })  : _filter = filter,
        super(error);

  final QuestionFilter _filter;
  final int questionNumber;

  QuestionFilter get filter => _filter;

  factory CreateQuizState.initial() =>
      CreateQuizState(filter: QuestionFilter(), questionNumber: 0);

  CreateQuizState _updateFilter(QuestionFilter filter) =>
      __copyWith(filter: filter);

  _Updating _updateing() => _Updating(this);

  CreateQuizState _updateQuestionNumber(int questionNumber) =>
      __copyWith(questionNumber: questionNumber);

  CreateQuizState _errorOccured(String error) =>
      __copyWith(error: error);

  CreateQuizState __copyWith({
    QuestionFilter? filter,
    int? questionNumber,
    String? error,
  }) =>
      CreateQuizState(
        filter: filter ?? _filter,
        questionNumber: questionNumber ?? this.questionNumber,
        error: error,
      );

  bool get isloading => this is _Updating;
}

class _Updating extends CreateQuizState {
  _Updating(CreateQuizState state)
      : super(
            filter: state._filter,
            questionNumber: state.questionNumber);
}
