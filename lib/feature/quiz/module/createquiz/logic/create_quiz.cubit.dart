import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/question/data/dto/question_filter.dto.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_quiz.state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  final _quizRepo = locator<QuizRepo>();

  CreateQuizCubit() : super(CreateQuizState.initial());

  final titleController =
      TextEditingController(text: DateTime.now().toString());

  double levelScroll = 0;
  double majorScroll = 0;

  void updateCourses(List<CourseModel> courses) =>
      _updateFilter(state._filter.copyWith(courses: courses));

  void updateSource(List<SourceModel> sources) =>
      _updateFilter(state._filter.copyWith(sources: sources));

  void updateYear(int year) =>
      _updateFilter(state._filter.copyWith(newYear: year));

  void updateDifficulties(List<String> difficulties) => _updateFilter(
      state._filter.copyWith(difficulties: difficulties));

  void updateTypes(List<String> types) =>
      _updateFilter(state._filter.copyWith(types: types));

  void updateWithExplain(bool withExplain) => _updateFilter(
      state._filter.copyWith(withExplanation: withExplain));

  void updateWithNote(bool withNote) =>
      _updateFilter(state._filter.copyWith(withNotes: withNote));

  void updateAlreadyAnsweredFalse(bool alreadyAnsweredFalse) =>
      _updateFilter(state._filter
          .copyWith(alreadyAnsweredFalse: alreadyAnsweredFalse));

  void _getQuestionNumber() async {
    emit(state._updateing());

    final result = await _quizRepo.getQuestionNumber(state._filter);

    result.when(
      success: (questionNumber) =>
          emit(state._updateQuestionNumber(questionNumber)),
      error: (error) => emit(state._updateQuestionNumber(0)),
    );
  }

  void _updateFilter(QuestionFilter filter) {
    emit(state._updateFilter(filter));
    _getQuestionNumber();
  }

  void createQuiz() async {
    if (state.questionNumber == 0) return;

    emit(state._createting());

    final result = await _quizRepo.createQuiz(
        title: titleController.text, filters: state._filter);

    result.when(
      success: (quiz) => emit(state._created(quiz)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
