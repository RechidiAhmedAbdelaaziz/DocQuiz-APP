import 'package:app/core/di/container.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_list.state.dart';

class QuizListCubit extends Cubit<QuizListState> {
  final _quizRepo = locator<QuizRepo>();
  QuizListCubit() : super(QuizListState.initial());

  final _query = KeywordQuery(limit: 7);
  int _page = 1;

  int get page => _page;

  void nextPage() {
    _page++;
    fetchQuizes();
  }

  void prePage() {
    if (_page > 1) {
      _page--;
      fetchQuizes();
    }
  }

  set keyword(String keyword) {
    _query.copyWith(keywords: keyword, page: 1);
    fetchQuizes(isSearch: true);
  }

  Future<void> fetchQuizes(
      {int? limit, int? page, bool isSearch = false}) async {
    _query.copyWith(limit: limit, page: _page);

    final result = await _quizRepo.getQuizzes(query: _query);

    result.when(
      success: (quizes) {
        if (quizes.isEmpty && !isSearch) {
          _page--;
          emit(state
              ._errorOccurred('Il n\'y a plus de quiz à charger'));
          return;
        }

        emit(state._fetchQuizes(quizes));
      },
      error: (error) => emit(state._errorOccurred(error.message)),
    );
  }

  void removeQuiz(QuizModel quiz) async {
    final result = await _quizRepo.deleteQuiz(id: quiz.id!);

    result.when(
      success: (_) => emit(state._removeQuiz(quiz)),
      error: (error) => emit(state._errorOccurred(error.message)),
    );
  }
}
