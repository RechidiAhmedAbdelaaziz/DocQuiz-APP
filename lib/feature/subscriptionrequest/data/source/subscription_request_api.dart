import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'subscription_request_api.g.dart';

@RestApi()
abstract class SubscriptionRequestApi {
  factory SubscriptionRequestApi(
    Dio dio,
  ) = _SubscriptionRequestApi;

  @GET(ApiConstants.subscriptionRequest)
  Future<PaginatedDataResponse> getAllRequests(
    @Queries() Map<String, dynamic> queries,
  );

  @PATCH(ApiConstants.subscriptionRequestWithId)
  Future<MessageResponse> approveRequest(
    @Path('id') String id,
  );

  @DELETE(ApiConstants.subscriptionRequestWithId)
  Future<MessageResponse> deleteRequest(
    @Path('id') String id,
  );
}
