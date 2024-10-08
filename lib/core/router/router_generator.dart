import 'package:flutter/material.dart';

import 'abstract_route.dart';

class AppRouter {
  const AppRouter();
  Route<T> generateRoute<T>(RouteSettings settings) {
    final route = settings.arguments as RouteBase<T>;
    return route.buildRoute();
  }
}
