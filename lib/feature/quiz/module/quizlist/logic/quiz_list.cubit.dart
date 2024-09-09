import 'package:app/core/di/container.dart';
import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/network/models/api_error.model.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_list.state.dart';

class QuizListCubit extends Cubit<QuizListState> {
  final _quizRepo = locator<QuizRepo>();
  QuizListCubit() : super(QuizListState.initial());

  final _query = KeywordQuery();

  set keyword(String keyword) {
    _query.copyWith(keywords: keyword, page: 1);
    state.quizes.clear();
  }

  Future<void> fetchQuizes() async {
    final result = await _quizRepo.getQuizzes(query: _query);

    result.when(
      success: (quizes) {
        if (quizes.isNotEmpty) _query.copyWith(page: _query.page + 1);
        emit(state._fetchQuizes(quizes));
      },
      error: (error) => emit(state._errorOccurred(error)),
    );
  }
}
