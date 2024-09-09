part of 'quiz_list.cubit.dart';

class QuizListState extends ErrorState {
  QuizListState({ApiErrorModel? error, this.quizes = const []})
      : super(error);

  final List<QuizModel> quizes;

  factory QuizListState.initial() => QuizListState();

  QuizListState _fetchQuizes(List<QuizModel> quizes) {
    this.quizes.addAllUniq(quizes);
    return QuizListState(quizes: this.quizes);
  }

  QuizListState _errorOccurred(ApiErrorModel error) {
    return QuizListState(error: error, quizes: quizes);
  }
}

