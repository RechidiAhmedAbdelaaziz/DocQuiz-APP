import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.model.g.dart';

@JsonSerializable(createToJson: false)
class PlaylistModel extends Equatable {
  const PlaylistModel({
    this.totalQuestions,
    this.id,
    this.title,
  });

  final num? totalQuestions;

  @JsonKey(name: '_id')
  final String? id;
  final String? title;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
