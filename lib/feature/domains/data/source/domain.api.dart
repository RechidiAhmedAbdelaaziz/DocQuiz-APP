import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'domain.api.g.dart';

@RestApi()
abstract class DomainApi {
  factory DomainApi(Dio dio, {String baseUrl}) = _DomainApi;

  @GET('/domains')
  Future<PaginatedDataResponse> getDomains();

  @GET('/levels')
  Future<PaginatedDataResponse> getDomain({
    @Query('domainId') String? domainId,
  });

  @GET('/majors')
  Future<PaginatedDataResponse> getMajor({
    @Query('levelId') String? levelId,
  });

  @GET('/majors/me')
  Future<PaginatedDataResponse> getMyMajor();

  @GET('/courses')
  Future<PaginatedDataResponse> getCourse({
    @Query('majorId') String? majorId,
  });
}
