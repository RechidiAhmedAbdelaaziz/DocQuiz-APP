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
  bool get isSetting => this is _Settings;
}

class _Dashboard extends HomeState {
  _Dashboard() : super(DashboardRoute());
}

class _MyQuiz extends HomeState {
  _MyQuiz() : super(MyQuizRoute());
}

class _Settings extends HomeState {
  _Settings() : super(DashboardRoute());
}
