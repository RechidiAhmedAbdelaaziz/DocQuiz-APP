import 'package:flutter/material.dart';

import 'abstract_route.dart';

abstract class AppNavigator<D> {
  set generateRoute(RouteBase settings) {
    settings.navigator = this;
  }

  MaterialPageRoute<D> buildRoute(String path, Widget child);
}

class NormalNavigator<D> extends AppNavigator<D> {
  @override
  MaterialPageRoute<D> buildRoute(String path, Widget child) {
    return MaterialPageRoute(
      settings: RouteSettings(name: path),
      builder: (_) => child,
    );
  }
}

// navigator that you can't pop to it when you navigate from it
class NoPopNavigator<D> extends AppNavigator<D> {
  @override
  MaterialPageRoute<D> buildRoute(String path, Widget child) {
    return MaterialPageRoute(
      settings: RouteSettings(name: path),
      builder: (_) => PopScope(
        canPop: false,
        child: child,
      ),
    );
  }
}
