import 'package:app/core/di/container.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/exam.repo.dart';

part 'exam-record.state.dart';

class ExamRecordCubit extends Cubit<ExamRecordState> {
  final _examRepo = locator<ExamRepo>();
  final _authCache = locator<AuthCache>();

  ExamRecordCubit() : super(ExamRecordState());

  Future<void> getExamRecords({
    MajorModel? major,
    String? type,
  }) async {
    final domainId = major == null ? await _authCache.domain : null;

    final response = await _examRepo.getExamRecords(
      majorId: major?.id,
      domainId: domainId,
      type: type,
    );

    response.when(
      success: (data) {
        emit(state.copyWith(years: data.years));
      },
      error: (message) {
        emit(state.copyWith());
      },
    );
  }
}
