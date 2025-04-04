import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'exam.api.g.dart';

@RestApi()
abstract class ExamApi {
  factory ExamApi(Dio dio, {String baseUrl}) = _ExamApi;

  @GET('/exam')
  Future<PaginatedDataResponse> getExams(
    @Queries() Map<String, dynamic> queries,
  );

  @GET('exam-record')
  Future<DataResponse> getExamRecords(
    @Queries() Map<String, dynamic> queries,
  );
}
