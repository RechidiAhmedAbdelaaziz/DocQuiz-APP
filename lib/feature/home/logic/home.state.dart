part of 'home.cubit.dart';

abstract class HomeState {
  HomeState(this.child);

  final Widget child;

  bool get isDashboard => this is _Dashboard;
  bool get isSetting => this is _Settings;
}

class _Dashboard extends HomeState {
  _Dashboard() : super(const Dashboard());
}

class _Settings extends HomeState {
  _Settings() : super(const LoginScreen());
}
