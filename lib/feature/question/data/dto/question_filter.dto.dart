import 'package:app/feature/user/data/model/field.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_filter.dto.g.dart';

@JsonSerializable(createFactory: false)
class QuestionFilter {
    QuestionFilter({
        required this.title,
        required this.fields,
        required this.difficulties,
        required this.types,
        required this.alreadyAnsweredFalse,
        required this.withExplanation,
        required this.withNotes,
    });

    final String? title;
    final List<Field>? fields;
    final List<String>? difficulties;
    final List<String>? types;
    final bool? alreadyAnsweredFalse;
    final bool? withExplanation;
    final bool? withNotes;

    Map<String, dynamic> toJson() => _$QuestionFilterToJson(this);

}

