import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_offer_model.g.dart';

@JsonSerializable(createToJson: false)
class SubscriptionOfferModel extends Equatable {
  const SubscriptionOfferModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.domain,
    this.levels = const [],
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final DomainModel? domain;
  final List<LevelModel> levels;

  factory SubscriptionOfferModel.fromJson(
          Map<String, dynamic> json) =>
      _$SubscriptionOfferModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
