part of 'quiz_list.cubit.dart';

class QuizListState extends ErrorState {
  QuizListState({String? error, List<QuizModel>? quizes})
      : quizes = quizes ?? [],
        super(error);

  final List<QuizModel> quizes;

  factory QuizListState.initial() => QuizListState();

  QuizListState _fetchQuizes(List<QuizModel> quizes) {
    return QuizListState(quizes: quizes);
  }

  QuizListState _removeQuiz(QuizModel quiz) {
    quizes.remove(quiz);
    for (var i = 0; i < quizes.length; i++) {
    }
    return QuizListState(quizes: quizes);
  }

  QuizListState _errorOccurred(String error) {
    return QuizListState(error: error, quizes: quizes);
  }
}
