part of 'home.cubit.dart';

abstract class HomeState {
  HomeState(DrawerRoute route) : child = route.child {
    routesStack.add(this);
    print("Last route: $this");
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
  bool get isExam => this is _Exam;
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

class _Exam extends HomeState {
  _Exam() : super(ExamRoute());
}

class _Profile extends HomeState {
  _Profile() : super(ProfileRoute());
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
