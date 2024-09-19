import 'package:app/core/di/container.dart';
import 'package:app/core/types/api_result.type.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/data/repo/domain.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'names.state.dart';

class NamesCubit<T extends NamedModel, D>
    extends Cubit<NamesState<T>> {
  final _domainRepo = locator<DomainRepo>();
  D? _parent;

  NamesCubit() : super(NamesState.initial());

  set setParent(D? value) {
    if (value != _parent) {
      _parent = value;
      fetchAll();
    }
  }

  D? get parent => _parent;

  void fetchAll() async {
    late final ApiResult<List<T>> result;
    switch (T) {
      case const (DomainModel):
        result =
            (await _domainRepo.getDomains()) as ApiResult<List<T>>;
        break;
      case const (LevelModel):
        final id = await locator<AuthCache>().domain;
        result = (await _domainRepo.getLevels(domainId: id))
            as ApiResult<List<T>>;
        break;
      case const (MajorModel):
        result = (await _domainRepo.getMajors(
            level: _parent as LevelModel?)) as ApiResult<List<T>>;
        break;
      case const (CourseModel):
        result = (await _domainRepo.getCourses(
            major: _parent as MajorModel?)) as ApiResult<List<T>>;
        break;

      case const (SourceModel):
        result =
            (await _domainRepo.getSources()) as ApiResult<List<T>>;
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
