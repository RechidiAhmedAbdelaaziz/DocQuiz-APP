import 'package:app/core/di/container.dart';
import 'package:app/core/types/api_result.type.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/data/repo/domain.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'names.state.dart';

class NamesCubit<T extends NamedModel, D>
    extends Cubit<NamesState<T>> {
  final _domainRepo = locator<DomainRepo>();

  NamesCubit() : super(NamesState.initial());

  void fetchAll({D? parent}) async {
    late final ApiResult<List<T>> result;
    switch (T) {
      case const (DomainModel):
        result =
            (await _domainRepo.getDomains()) as ApiResult<List<T>>;
        break;
      case const (LevelModel):
        result = _domainRepo.getLevels(domain: parent as DomainModel)
            as ApiResult<List<T>>;
        break;
      case const (MajorModel):
        result = _domainRepo.getMajors(level: parent as LevelModel)
            as ApiResult<List<T>>;
        break;
      case const (CourseModel):
        result = _domainRepo.getCourses(major: parent as MajorModel)
            as ApiResult<List<T>>;
        break;
    }

    _handleResult(result);
  }

  void _handleResult(ApiResult<List<T>> result) {
    result.when(
      success: (items) => emit(state.fetchLevels(items)),
      error: (error) => emit(state.errorOccurred(error.message)),
    );
  }
}
