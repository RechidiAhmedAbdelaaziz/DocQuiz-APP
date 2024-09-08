import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'quiz.api.g.dart';

@RestApi()
abstract class QuizApi {
  factory QuizApi(Dio dio, {String baseUrl}) = _QuizApi;

  @GET(ApiConstants.QUIZ)
  Future<PaginatedDataResponse> getQuizzes(
    @Queries() Map<String, dynamic> queries,
  );

  @POST(ApiConstants.QUIZ)
  Future<DataResponse> createQuiz(
    @Body() Map<String, dynamic> body,
  );

  @PATCH(ApiConstants.QUIZ_ID)
  Future<DataResponse> updateQuiz(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.QUIZ_ID)
  Future<MessageResponse> deleteQuiz(
    @Path('id') String id,
  );

  @GET(ApiConstants.QUESTION_NUMBER)
  Future<DataResponse> getQuestionNumber(
    @Queries() Map<String, dynamic> queries,
  );

  
}
