// ignore_for_file: library_private_types_in_public_api

import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'question.state.dart';

typedef _OnAnswered = void Function(QuestionResultModel question);

class QuestionCubit extends Cubit<QuestionState> {
  final RepoListResult<QuestionResultModel> Function(
      PaginationQuery query) _fetchFunction;

  final _OnAnswered? _onAnswered;

  QuestionCubit(int max, this._fetchFunction,
      {_OnAnswered? onAnswered})
      : _onAnswered = onAnswered,
        super(QuestionState.initial(max));

  final _query = PaginationQuery(page: 1, limit: 10);

  final myChoices = <String>[];

  bool get nextExist => state._currentIndex + 1 < state._max;
  bool get previousExist => state._currentIndex > 0;

  set choseAnswer(String choice) {
    if (state.question?.result?.isAnswerd == true) return;
    if (state.question?.question.type == "QCM") {
      myChoices.addOrRemove(choice);
    } else {
      myChoices.clear();
      myChoices.add(choice);
    }
    emit(state._copyWith());
  }

  void nextQuestion() {
    if (state._currentIndex + 1 < state._max) {
      showQuestion(state._currentIndex + 1);
    }
  }

  void previousQuestion() {
    if (state._currentIndex > 0) {
      showQuestion(state._currentIndex - 1);
    }
  }

  void showQuestion(int index) async {
    if (index != state._currentIndex) myChoices.clear();

    if (!state.exists(index)) {
      await fetchQuestions(page: state.page(index));
    }

    emit(state._toQuestion(index));
  }

  void answerQuestion() {
    emit(state._answerQuestion(myChoices));

    _onAnswered?.call(state._questions[state._currentIndex]!);
  }

  Future<void> fetchQuestions({int? page}) async {
    final result = await _fetchFunction(_query..copyWith(page: page));

    result.when(
      success: (questions) {
        emit(state.._fetchQuestions(questions, page: _query.page));
      },
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
