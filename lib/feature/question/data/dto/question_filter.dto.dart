import 'package:app/core/extension/list.extension.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';

class QuestionFilter {
  QuestionFilter({
    List<CourseModel>? courses,
    List<String>? difficulties,
    List<String>? types,
    this.alreadyAnsweredFalse = false,
    this.withExplanation = false,
    this.withNotes = false,
    List<SourceModel>? sources,
    this.year = 0,
  })  : courses = courses ?? [],
        difficulties = difficulties ?? [],
        types = types ?? [],
        sources = sources ?? [];

  final List<CourseModel> courses;
  final List<String> difficulties;
  final List<String> types;
  final bool alreadyAnsweredFalse;
  final bool withExplanation;
  final bool withNotes;
  final List<SourceModel> sources;
  final int year;

  QuestionFilter copyWith({
    List<CourseModel>? courses,
    List<String>? difficulties,
    List<String>? types,
    bool? alreadyAnsweredFalse,
    bool? withExplanation,
    bool? withNotes,
    List<SourceModel>? sources,
    int? newYear,
  }) {
    if (courses != null) this.courses.addOrRemoveAll(courses);
    if (difficulties != null) {
      this.difficulties.addOrRemoveAll(difficulties);
    }
    if (types != null) this.types.addOrRemoveAll(types);
    if (sources != null) this.sources.addOrRemoveAll(sources);

    return QuestionFilter(
      courses: this.courses,
      difficulties: this.difficulties,
      types: this.types,
      alreadyAnsweredFalse:
          alreadyAnsweredFalse ?? this.alreadyAnsweredFalse,
      withExplanation: withExplanation ?? this.withExplanation,
      withNotes: withNotes ?? this.withNotes,
      sources: this.sources,
      year: newYear ?? year,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['courses'] = courses.map((e) => e.id).toList();

    if (difficulties.isNotEmpty) json['difficulties'] = difficulties;

    if (types.isNotEmpty) json['types'] = types;

    if (alreadyAnsweredFalse) json['alreadyAnsweredFalse'] = true;

    if (withExplanation) json['withExplanation'] = true;

    if (withNotes) json['withNotes'] = true;

    if (sources.isNotEmpty) {
      json['sources'] = sources.map((e) => e.id).toList();
    }

    json['year'] = year;

    return json;
  }

  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> query = {};

    query['courses[]'] = courses.map((e) => e.id).toList();

    if (difficulties.isNotEmpty) {
      query['difficulties[]'] = difficulties;
    }
    if (types.isNotEmpty) query['types[]'] = types;

    if (alreadyAnsweredFalse) query['alreadyAnsweredFalse'] = true;

    if (withExplanation) query['withExplanation'] = true;

    if (withNotes) query['withNotes'] = true;

    if (sources.isNotEmpty) {
      query['sources[]'] = sources.map((e) => e.id).toList();
    }

    query['year'] = year;

    return query;
  }
}
