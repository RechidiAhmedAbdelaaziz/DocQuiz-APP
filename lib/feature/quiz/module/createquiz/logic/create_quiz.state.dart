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

  CreateQuizState _createting() => _Creating(this);

  CreateQuizState _created(QuizModel quiz) => _Created(quiz, this);

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
  bool get isCreating => this is _Creating;

  void onCreated(void Function(QuizModel quiz) onCreated) {
    if (this is _Created) onCreated((this as _Created).quiz);
  }
}

class _Updating extends CreateQuizState {
  _Updating(CreateQuizState state)
      : super(
            filter: state._filter,
            questionNumber: state.questionNumber);
}

class _Creating extends CreateQuizState {
  _Creating(CreateQuizState state)
      : super(
            filter: state._filter,
            questionNumber: state.questionNumber);
}

class _Created extends CreateQuizState {
  final QuizModel quiz;
  _Created(this.quiz, CreateQuizState state)
      : super(
            filter: state._filter,
            questionNumber: state.questionNumber);
}
