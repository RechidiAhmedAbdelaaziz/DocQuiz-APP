import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/feature/firstpage/ui/first.screen.dart';
import 'package:flutter/material.dart';

import 'abstract_route.dart';

class AppRouter {
  const AppRouter();
  Route<T> generateRoute<T>(RouteSettings settings) {
    final route = settings.arguments as RouteBase<T>?;

    if (route == null) {
      return MaterialPageRoute(
        builder: (ctx) {
          return FirstScreen();
        },
      );
    }
    return route.buildRoute();
  }
}
