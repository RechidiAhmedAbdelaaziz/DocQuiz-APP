import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/quiz/data/dto/update_quiz.dto.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz.state.dart';

class QuizCubit extends Cubit<QuizState> {
  final _quizRepo = locator<QuizRepo>();

  QuizCubit(QuizModel quiz) : super(QuizState.initial(quiz));

  void updateTitle(String title) async {
    final result = await _quizRepo.updateQuiz(
      id: state.quiz.id!,
      updates: UpdateQuizBody(title: title),
    );

    result.when(
      success: (quiz) => emit(QuizState.update(quiz)),
      error: (error) => emit(state.errorOccured(error.message)),
    );
  }
}
