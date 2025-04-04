import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/exam/data/model/exam.model.dart';
import 'package:app/feature/exam/data/source/exam.api.dart';

class ExamRepo {
  final _examApi = locator<ExamApi>();

  RepoListResult<ExamModel> getExams(
    KeywordQuery query, {
    String? majorId,
    int? year,
    String? domainId,
  }) async {
    apiCall() async {
      final response = await _examApi.getExams({
        ...query.toJson(),
        if (majorId != null) 'majorId': majorId,
        if (year != null) 'year': year,
        if (domainId != null) 'domainId': domainId,

      });
      return response.data!
          .map((e) => ExamModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<ExamRecordModel> getExamRecords({
    String? majorId,
    String? domainId,
    String? type,
  }) async {
    apiCall() async {
      final response = await _examApi.getExamRecords({
        if (majorId != null) 'majorId': majorId,
        if (domainId != null && type != null)
          'domain': {"domainId": domainId, "type": type}
      });

      return ExamRecordModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }
}
