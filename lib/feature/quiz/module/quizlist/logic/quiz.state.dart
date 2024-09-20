part of 'quiz.cubit.dart';

class QuizState extends ErrorState {
  final QuizModel quiz;

  QuizState({
    required this.quiz,
    String? error,
  }) : super(error);

  factory QuizState.initial(QuizModel quiz) => QuizState(quiz: quiz);
  factory QuizState.update(QuizModel quiz) => QuizState(quiz: quiz);
  

  QuizState errorOccured(String error) {
    return QuizState(quiz: quiz, error: error);
  }
}
