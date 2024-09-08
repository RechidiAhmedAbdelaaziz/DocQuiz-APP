import 'package:json_annotation/json_annotation.dart';

part 'field.model.g.dart';

@JsonSerializable()
class Field {
    Field({
        required this.level,
        required this.major,
        required this.course,
    });

    final String? level;
    final String? major;
    final String? course;

    factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

    Map<String, dynamic> toJson() => _$FieldToJson(this);

}
