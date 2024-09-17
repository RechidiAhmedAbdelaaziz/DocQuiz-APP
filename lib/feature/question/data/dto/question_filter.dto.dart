import 'package:app/core/extension/list.extension.dart';

class QuestionFilter {
  QuestionFilter({
    List<String>? courses,
    List<String>? difficulties,
    List<String>? types,
    this.alreadyAnsweredFalse = false,
    this.withExplanation = false,
    this.withNotes = false,
    List<String>? sources,
    this.year = 2000,
  })  : courses = courses ?? ['66e86b90260ca2456cf480c4'],
        difficulties = difficulties ?? [],
        types = types ?? [],
        sources = sources ?? [];
        

  final List<String> courses;
  final List<String> difficulties;
  final List<String> types;
  final bool alreadyAnsweredFalse;
  final bool withExplanation;
  final bool withNotes;
  final List<String> sources;
  final int year;

  QuestionFilter copyWith({
    String? newCourse,
    String? newDifficulty,
    String? newType,
    bool? alreadyAnsweredFalse,
    bool? withExplanation,
    bool? withNotes,
    String? newSource,
    int? newYear,
  }) {
    if (newCourse != null) courses.addOrRemove(newCourse);
    if (newDifficulty != null) {
      difficulties.addOrRemove(newDifficulty);
    }
    if (newType != null) types.addOrRemove(newType);
    if (newSource != null) sources.addOrRemove(newSource);
    

    return QuestionFilter(
      courses: courses,
      difficulties: difficulties,
      types: types,
      alreadyAnsweredFalse:
          alreadyAnsweredFalse ?? this.alreadyAnsweredFalse,
      withExplanation: withExplanation ?? this.withExplanation,
      withNotes: withNotes ?? this.withNotes,
      sources: sources,
      year: newYear ?? year,
    );
  }

  Map<String, dynamic> toJson() => {
        'courses': courses,
        'difficulties': difficulties,
        'types': types,
        'alreadyAnsweredFalse': alreadyAnsweredFalse,
        'withExplanation': withExplanation,
        'withNotes': withNotes,
        'sources': sources,
        'year': year,
      };

  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> query = {};

    if (courses.isNotEmpty) query['courses[]'] = courses;

    if (difficulties.isNotEmpty) {
      query['difficulties[]'] = difficulties;
    }
    if (types.isNotEmpty) query['types[]'] = types;

    if (alreadyAnsweredFalse) query['alreadyAnsweredFalse'] = true;

    if (withExplanation) query['withExplanation'] = true;

    if (withNotes) query['withNotes'] = true;

    if (sources.isNotEmpty) query['sources[]'] = sources;

    query['year'] = year;

    return query;
  }
}
