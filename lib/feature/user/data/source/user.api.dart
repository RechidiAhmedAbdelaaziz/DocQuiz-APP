import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user.api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET(ApiConstants.PROFILE)
  Future<DataResponse> getProfile();

  @PATCH(ApiConstants.PROFILE)
  Future<DataResponse> updateProfile(
      @Body() Map<String, dynamic> body);

  @PATCH(ApiConstants.PASSWORD)
  Future<MessageResponse> updatePassword(
      @Body() Map<String, dynamic> body);
}
