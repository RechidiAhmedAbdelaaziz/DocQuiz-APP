import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'updates.api.g.dart';

@RestApi()
abstract class UpdatesApi {
  factory UpdatesApi(Dio dio, {String baseUrl}) = _UpdatesApi;

  @GET(ApiConstants.UPDATES)
  Future<PaginatedDataResponse> getUpdates();
}
