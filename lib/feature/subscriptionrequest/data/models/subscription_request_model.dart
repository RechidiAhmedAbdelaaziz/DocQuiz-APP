import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_request_model.g.dart';

@JsonSerializable(createToJson: false)
class SubscriptionRequestModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final UserModel? user;
  final SubscriptionOfferModel? offer;
  final String? proof;

  const SubscriptionRequestModel({
    this.id,
    this.user,
    this.offer,
    this.proof,
  });

  factory SubscriptionRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$SubscriptionRequestModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
