import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'question.api.g.dart';

@RestApi()
abstract class QuestionApi {
  factory QuestionApi(Dio dio, {String baseUrl}) = _QuestionApi;

  @GET('quiz/{quizId}')
  Future<PaginatedDataResponse> getQuestions(
    @Path('quizId') String quizId,
    @Queries() Map<String, dynamic> query,
  );

  @GET('/playlist/{playlistId}')
  Future<PaginatedDataResponse> getQuestionsByPlaylist(
    @Path('playlistId') String playlistId,
    @Queries() Map<String, dynamic> query,
  );

  @GET('/exam/{examId}')
  Future<PaginatedDataResponse> getQuestionsByExam(
    @Path('examId') String examId,
    @Queries() Map<String, dynamic> query,
  );
}
