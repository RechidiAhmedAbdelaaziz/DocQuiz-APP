import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/data/source/domain.api.dart';

class DomainRepo {
  final _domainApi = locator<DomainApi>();

  RepoListResult<DomainModel> getDomains() {
    apiCall() async {
      final response = await _domainApi.getDomains();
      return response.data!
          .map((e) => DomainModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoListResult<LevelModel> getLevels({String? domainId}) {
    apiCall() async {
      final response = await _domainApi.getDomain(domainId: domainId);
      return response.data!
          .map((e) => LevelModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoListResult<MajorModel> getMajors({LevelModel? level}) {
    apiCall() async {
      final response = await _domainApi.getMajor(levelId: level?.id);
      return response.data!
          .map((e) => MajorModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoListResult<MajorModel> getMyMajor() {
    apiCall() async {
      final response = await _domainApi.getMyMajor();
      return response.data!
          .map((e) => MajorModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoListResult<CourseModel> getCourses({MajorModel? major}) {
    apiCall() async {
      final response = await _domainApi.getCourse(majorId: major?.id);
      return response.data!
          .map((e) => CourseModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoListResult<SourceModel> getSources() {
    apiCall() async {
      final response = await _domainApi.getSources();
      return response.data!
          .map((e) => SourceModel.fromJson(e))
          .toList();
    }

    return TryCallApi.call(apiCall);
  }
}
