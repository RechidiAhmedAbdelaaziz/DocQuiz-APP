import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.model.g.dart';

@JsonSerializable(createToJson: false)
class PlaylistModel extends Equatable {
  const PlaylistModel({
    this.totalQuestions,
    this.id,
    this.title,
    this.isIn
  });

  final int? totalQuestions;

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final bool? isIn;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
