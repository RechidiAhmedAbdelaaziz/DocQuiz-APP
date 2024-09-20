import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel {
  UserModel({
    required this.id,
    required this.isPro,
    required this.name,
    required this.email,
    required this.domain,
    required this.level,
  });

  @JsonKey(name: '_id')
  final String? id;
  final bool? isPro;
  final String? name;
  final String? email;
  final DomainModel? domain;
  final LevelModel? level;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
