import 'package:app/core/di/container.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:app/feature/exam/data/repo/exam.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam.state.dart';

class ExamCubit extends Cubit<ExamState> {
  final _examRepo = locator<ExamRepo>();
  ExamCubit() : super(ExamState.initial());

  final _query = KeywordQuery();

  set keyword(String keyword) {
    _query.copyWith(keywords: keyword, page: 1);
    fetchExams(isSrech: true);
  }

  int get page => _query.page - 1;

  void nextPage() => fetchExams();

  void prevPage() {
    _query.copyWith(page: page);
    fetchExams();
  }

  Future<void> fetchExams({bool isSrech = false}) async {
    final result = await _examRepo.getExams(_query);
    result.when(
      success: (exams) {
        if (exams.isNotEmpty) _query.nextPage();
        if (isSrech || exams.isNotEmpty) {
          return emit(state._fetchExams(exams));
        }
        emit(state
            ._errorOccured('Il n\'y a pas d\'examen disponible'));
      },
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
