import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/question/data/dto/question_filter.dto.dart';
import 'package:app/feature/quiz/data/dto/update_quiz.dto.dart';
import 'package:app/feature/quiz/data/models/quiz.model.dart';
import 'package:app/feature/quiz/data/source/quiz.api.dart';

class QuizRepo {
  final _quizApi = locator<QuizApi>();

  RepoListResult<QuizModel> getQuizzes({
    required KeywordQuery query,
  }) async {
    apiCall() async {
      final response = await _quizApi.getQuizzes(query.toJson());
      return response.data!
          .map((e) => QuizModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<QuizModel> createQuiz({
    required QuestionFilter filters,
  }) async {
    apiCall() async {
      final response = await _quizApi.createQuiz(filters.toJson());
      return QuizModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<QuizModel> updateQuiz({
    required String id,
    required UpdateQuizBody updates,
  }) async {
    apiCall() async {
      final response =
          await _quizApi.updateQuiz(id, updates.toJson());
      return QuizModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<void> deleteQuiz({
    required String id,
  }) async {
    apiCall() async => await _quizApi.deleteQuiz(id);

    return await TryCallApi.call(apiCall);
  }

  RepoResult<int> getQuestionNumber({
    required QuestionFilter filters,
  }) async {
    apiCall() async {
      final response =
          await _quizApi.getQuestionNumber(filters.toJson());
      return response.data!['questions'] as int;
    }

    return await TryCallApi.call(apiCall);
  }
}
