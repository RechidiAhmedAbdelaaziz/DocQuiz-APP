import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST(ApiConstants.LOGIN)
  Future<TokensResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.REGISTER)
  Future<TokensResponse> register(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.REFRESH_TOKEN)
  Future<TokensResponse> refreshToken(
      @Query('refreshToken') String refreshToken);

  @POST(ApiConstants.FORGOT_PASSWORD)
  Future<MessageResponse> forgotPassword(
      @Body() Map<String, dynamic> body);

  @POST(ApiConstants.VERIFY_OTP)
  Future<MessageResponse> verifyOtp(
      @Body() Map<String, dynamic> body);

  @POST(ApiConstants.RESET_PASSWORD)
  Future<MessageResponse> resetPassword(
      @Body() Map<String, dynamic> body);

  @GET(ApiConstants.GOOGLE_CALLBACK)
  Future<TokensResponse> googleCallback(@Query('code') String code);
}
