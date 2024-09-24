part of 'my_majors.cubit.dart';

class MyMajorsState extends ErrorState {
  MyMajorsState({
    List<MajorModel>? majors,
    Map<MajorModel, List<CourseModel>>? courses,
    String? error,
  })  : majors = majors ?? [],
        _courses = courses ?? {},
        super(error);

  final List<MajorModel> majors;
  final Map<MajorModel, List<CourseModel>> _courses;

  List<CourseModel>? coursesFor(MajorModel major) => _courses[major];

  factory MyMajorsState.initial() => MyMajorsState();

  MyMajorsState _fetchMajors(List<MajorModel> majors) =>
      copyWith(majors: majors);

  MyMajorsState _fetchCourses(
      MajorModel major, List<CourseModel> courses) {
    _courses[major] = courses;
    return copyWith(courses: _courses);
  }

  MyMajorsState _errorOccured(String error) => copyWith(error: error);

  MyMajorsState copyWith({
    List<MajorModel>? majors,
    Map<MajorModel, List<CourseModel>>? courses,
    String? error,
  }) {
    return MyMajorsState(
      majors: majors ?? this.majors,
      courses: courses ?? _courses,
      error: error,
    );
  }
}
