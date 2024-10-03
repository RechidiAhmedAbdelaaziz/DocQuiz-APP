// ignore_for_file: library_private_types_in_public_api

import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/shared/widgets/timer.dart';
import 'package:app/core/theme/icons.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'question.state.dart';

typedef _OnAnswered = void Function(
    QuestionResultModel question, int index);

class QuestionCubit extends Cubit<QuestionState> {
  final RepoListResult<QuestionResultModel> Function(
      PaginationQuery query) _fetchFunction;

  final _OnAnswered? _onAnswered;

  final TimeCubit _timeCubit;

  QuestionCubit(
    int max,
    this._fetchFunction, {
    _OnAnswered? onAnswered,
    required TimeCubit timeCubit,
    List<int>? correctIndexes,
    Map<int, List<int>>? wrongIndexes,
  })  : _onAnswered = onAnswered,
        _timeCubit = timeCubit,
        super(
            QuestionState.initial(max, correctIndexes, wrongIndexes));

  final _query = PaginationQuery(page: 1, limit: 10);

  final List<List<int>> myChoices = [];

  bool get nextExist => state._currentIndex! + 1 < state.max;
  bool get previousExist => state._currentIndex! > 0;

  void choseAnswer(Question question, int choice) {
    final index =
        state.question!.question.questions!.indexOf(question);
    if (state.question!.result.isAnswerd == true) return;
    if (state.question!.question.questions![index].type == "QCM") {
      myChoices[index].addOrRemove(choice);
    } else {
      myChoices[index].clear();
      myChoices[index].add(choice);
    }
    emit(state._copyWith());
  }

  void nextQuestion() {
    if (state._currentIndex! + 1 < state.max) {
      toQuestion(state._currentIndex! + 1);
    }
  }

  void previousQuestion() {
    if (state._currentIndex! > 0) {
      toQuestion(state._currentIndex! - 1);
    }
  }

  void toQuestion(int index, {bool isInitial = false}) async {
    if (!state.isExists(index)) {
      await fetchQuestions(page: (index ~/ 10) + 1);
    }

    if (index != state._currentIndex || isInitial) {
      myChoices.clear();
      for (var i = 0;
          i < state.questions[index]!.question.questions!.length;
          i++) {
        myChoices.add([]);
      }
    }
    if (!isInitial) state._saveTime(_timeCubit.state.seconds);

    emit(state._toQuestion(index));

    _timeCubit.start(newTime: state.question?.result.time ?? 0);

    if (state.question?.result.isAnswerd == true) {
      _timeCubit.stopWhenStopwatch();
    }
  }

  Future<void> answerQuestion() async {
    emit(state._answerQuestion(myChoices));

    final player = AudioPlayer();

    state.question!.result.isAllCorrect
        ? await player.play(AssetSource(AppSounds.valid))
        : await player.play(AssetSource(AppSounds.invalid));

    state._saveTime(_timeCubit.state.seconds);

    _timeCubit.stopWhenStopwatch();

    _onAnswered?.call(state.question!, state._currentIndex!);
  }

  void toSubQuestion(int index) {
    emit(state._toSubQuestion(index));
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
