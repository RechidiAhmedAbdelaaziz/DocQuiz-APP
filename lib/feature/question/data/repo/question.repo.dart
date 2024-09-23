import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/data/source/question.api.dart';

class QuestionRepo {
  final _questionApi = locator<QuestionApi>();

  RepoListResult<QuestionResultModel> getQuizQuestions(
    String quizId, {
    required PaginationQuery query,
  }) async {
    apiCall() async {
      final response =
          await _questionApi.getQuestions(quizId, query.toJson());

      return response.data!
          .map((e) => QuestionResultModel.fromJson(
                e['question'],
                resultJson: e['result'],
              ))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }

  RepoListResult<QuestionResultModel> getPlaylistQuestions(
    String playlistId, {
    required PaginationQuery query,
  }) async {
    apiCall() async {
      final response = await _questionApi.getQuestionsByPlaylist(
          playlistId, query.toJson());

      return response.data!
          .map((e) => QuestionResultModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }

  RepoListResult<QuestionResultModel> getExamQuestions(
    String examId, {
    required PaginationQuery query,
  }) async {
    apiCall() async {
      final response = await _questionApi.getQuestionsByExam(
          examId, query.toJson());

      return response.data!
          .map((e) => QuestionResultModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }
}
