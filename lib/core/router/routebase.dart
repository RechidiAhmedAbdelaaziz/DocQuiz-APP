import 'package:flutter/material.dart';

import 'navigator.dart';

abstract class RouterBase {
  final Widget _child;

  RouterBase({required Widget child}) : _child = child;
}

abstract class DrawerRoute extends RouterBase {
  DrawerRoute({required super.child});

  Widget get child => _child;
}

/// [T] return type of the route
abstract class NavigationRoute<T> extends RouterBase {
  NavigationRoute(this._path, {required super.child});

  final String _path;
  AppNavigator<T> _navigator = NormalNavigator<T>();

  String get path => _path;

  set navigator(AppNavigator<T> navigator) {
    _navigator = navigator;
  }

  MaterialPageRoute<T> buildRoute() =>
      _navigator.buildRoute(_path, _child);
}
