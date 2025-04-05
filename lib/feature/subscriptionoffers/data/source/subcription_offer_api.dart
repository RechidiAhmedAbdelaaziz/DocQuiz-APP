import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'subcription_offer_api.g.dart';

@RestApi()
abstract class SubscriptionOfferApi {
  factory SubscriptionOfferApi(Dio dio, {String baseUrl}) =
      _SubscriptionOfferApi;

  @GET(ApiConstants.subscriptionOfferWithId)
  Future<PaginatedDataResponse> getSubscriptionOffers(
    @Path('id') String id,
    @Queries() Map<String, dynamic>? queries,
  );

  @POST(ApiConstants.subscriptionOffer)
  Future<DataResponse> createSubscriptionOffer(
    @Body() Map<String, dynamic> body,
  );

  @PATCH(ApiConstants.subscriptionOfferWithId)
  Future<DataResponse> updateSubscriptionOffer(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.subscriptionOfferWithId)
  Future<MessageResponse> deleteSubscriptionOffer(
    @Path('id') String id,
  );
}
