// ignore_for_file: library_private_types_in_public_api

import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/shared/widgets/timer.dart';
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

  final TimeCubit _timeCubit;

  QuestionCubit(int max, this._fetchFunction,
      {_OnAnswered? onAnswered, required TimeCubit timeCubit})
      : _onAnswered = onAnswered,
        _timeCubit = timeCubit,
        super(QuestionState.initial(max));

  final _query = PaginationQuery(page: 1, limit: 10);

  final myChoices = <String>[];

  bool get nextExist => state._currentIndex + 1 < state._max;
  bool get previousExist => state._currentIndex > 0;

  set choseAnswer(String choice) {
    if (state.question?.result.isAnswerd == true) return;
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
      toQuestion(state._currentIndex + 1);
    }
  }

  void previousQuestion() {
    if (state._currentIndex > 0) {
      toQuestion(state._currentIndex - 1);
    }
  }

  void toQuestion(int index) async {
    if (index != state._currentIndex) myChoices.clear();

    if (!state.exists(index)) {
      await fetchQuestions(page: state.page(index));
    }

    emit(state._saveTime(_timeCubit.state.seconds));

    emit(state._toQuestion(index));

    _timeCubit.start(newTime: state.question?.result.time ?? 0);

    if (state.question?.result.isAnswerd == true) {
      _timeCubit.stopWhenStopwatch();
    }
  }

  void answerQuestion() {
    emit(state._answerQuestion(myChoices));
    print(state._questions.length);

    _timeCubit.stopWhenStopwatch();

    _onAnswered?.call(state.question!);
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
