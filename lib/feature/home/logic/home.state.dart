part of 'home.cubit.dart';

abstract class HomeState {
  HomeState(DrawerRoute route) : child = route.child {
    routesStack.add(this);
  }

  static final routesStack = <HomeState>[];
  HomeState? get previous {
    if (routesStack.length > 1) {
      routesStack.removeLast();
      return routesStack.last;
    }
    return null;
  }

  final Widget child;

  bool get isDashboard => this is _Dashboard;
  bool get isMyQuiz => this is _MyQuiz;
  bool get isCreateQuiz => this is _CreateQuiz;
  bool get isPlayList => this is _PlayList;
  bool get isExam => this is _Exam || this is _ExamFilter;
}

class _Dashboard extends HomeState {
  _Dashboard() : super(DashboardRoute());
}

class _MyQuiz extends HomeState {
  _MyQuiz() : super(MyQuizRoute());
}

class _CreateQuiz extends HomeState {
  _CreateQuiz() : super(CreateQuizRoute());
}

class _PlayList extends HomeState {
  _PlayList() : super(PlayListRoute());
}

class _ExamFilter extends HomeState {
  _ExamFilter(LevelModel? level, MajorModel? major, String? type)
      : super(ExamRoute.filter(level, major, type));
}

class _Exam extends HomeState {
  _Exam({
    MajorModel? major,
    String? type,
    required int year,
  }) : super(ExamRoute(major: major, type: type, year: year));
}

class _Profile extends HomeState {
  _Profile() : super(ProfileRoute());
}

class _QuizResult extends HomeState {
  _QuizResult.quiz(QuizModel quiz)
      : super(QuizResultRoute.quiz(quiz));

  _QuizResult.questions(String title,
      List<QuestionResultModel?> questions, int? totalTemps)
      : super(QuizResultRoute.questions(title, questions,
            totalTemps: totalTemps));
}



class _Loading extends HomeState {
  _Loading() : super(LoadingRoute());
}

class LoadingRoute extends DrawerRoute {
  LoadingRoute()
      : super(
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          ),
        );
}
