import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'subscription_api.g.dart';

@RestApi()
abstract class SubscriptionApi {
  factory SubscriptionApi(Dio dio, {String baseUrl}) =
      _SubscriptionApi;

  @GET(ApiConstants.subscription)
  Future<PaginatedDataResponse> getSubscription(
    @Queries() Map<String, dynamic> queries,
  );

  @POST(ApiConstants.subscription)
  Future<DataResponse> createSubscription(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.subscriptionWithId)
  Future<MessageResponse> deleteSubscription(
    @Path('id') String id,
  );
}
