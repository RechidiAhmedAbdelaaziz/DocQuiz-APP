import 'package:app/feature/subscriptionoffers/data/models/subscription_offer_model.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable(createToJson: false)
class SubscriptionModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final UserModel? user;
  final SubscriptionOfferModel? offer;
  final DateTime? endDate;

  const SubscriptionModel({
    this.id,
    this.user,
    this.offer,
    this.endDate,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
