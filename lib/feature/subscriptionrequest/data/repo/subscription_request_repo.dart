import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/shared/dto/pagination_dto.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/subscriptionrequest/data/source/subscription_request_api.dart';

import '../models/subscription_request_model.dart';

class SubscriptionRequestRepo {
  final _api = locator<SubscriptionRequestApi>();

  RepoListResult<SubscriptionRequestModel> getSubscriptionRequests(
      PaginationDto dto) async {
    apiCall() async {
      final response = await _api.getAllRequests(dto.toJson());
      return response.data!
          .map(
            (e) => SubscriptionRequestModel.fromJson(e),
          )
          .toList();
    }

    return TryCallApi.call(apiCall);
  }

  RepoResult<void> approveSubscriptionRequest(
          SubscriptionRequestModel request) =>
      TryCallApi.call(
          () async => await _api.approveRequest(request.id!));

  RepoResult<void> deleteSubscriptionRequest(
          SubscriptionRequestModel request) =>
      TryCallApi.call(
          () async => await _api.deleteRequest(request.id!));
}
