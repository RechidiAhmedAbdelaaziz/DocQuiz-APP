import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/question/data/dto/question_filter.dto.dart';
import 'package:app/feature/quiz/data/repo/quiz.repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_quiz.state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  final _quizRepo = locator<QuizRepo>();

  CreateQuizCubit() : super(CreateQuizState.initial());

  final titleController =
      TextEditingController(text: DateTime.now().toString());

  void updateCourses(CourseModel course) =>
      _updateFilter(state._filter.copyWith(newCourse: course.id));

  void updateSource(SourceModel source) =>
      _updateFilter(state._filter.copyWith(newSource: source.id));

  void updateYear(int year) =>
      _updateFilter(state._filter.copyWith(newYear: year));

  void updateDifficulty(String difficulty) => _updateFilter(
      state._filter.copyWith(newDifficulty: difficulty));

  void updateType(String type) =>
      _updateFilter(state._filter.copyWith(newType: type));

  void updateWithExplain(bool withExplain) => _updateFilter(
      state._filter.copyWith(withExplanation: withExplain));

  void updateWithNote(bool withNote) =>
      _updateFilter(state._filter.copyWith(withNotes: withNote));

  void updateAlreadyAnsweredFalse(bool alreadyAnsweredFalse) =>
      _updateFilter(state._filter
          .copyWith(alreadyAnsweredFalse: alreadyAnsweredFalse));

  void _getQuestionNumber() async {
    print(" OLD STATE : ${state.questionNumber}");
    emit(state._updateing());

    final result = await _quizRepo.getQuestionNumber(state._filter);

    result.when(
      success: (questionNumber) =>
          emit(state._updateQuestionNumber(questionNumber)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void _updateFilter(QuestionFilter filter) {
    emit(state._updateFilter(filter));
    _getQuestionNumber();
  }
}
