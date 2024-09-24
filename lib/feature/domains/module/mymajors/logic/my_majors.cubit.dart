import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/data/repo/domain.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_majors.state.dart';

class MyMajorsCubit extends Cubit<MyMajorsState> {
  final _repo = locator<DomainRepo>();
  MyMajorsCubit() : super(MyMajorsState.initial());

  void fetchMajors() async {
    final result = await _repo.getMyMajor();

    result.when(
      success: (majors) => emit(state._fetchMajors(majors)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void fetchCourses(MajorModel major) async {
    final result = await _repo.getCourses(major: major);

    result.when(
      success: (courses) => emit(state._fetchCourses(major, courses)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
