import 'package:flutter/material.dart';

import 'navigator.dart';

/// [T] return type of the route
abstract class RouteBase<T> {
  RouteBase(this._path, {required Widget child}) : _child = child;

  final String _path;
  final Widget _child;
  AppNavigator<T> _navigator = NormalNavigator<T>();

  String get path => _path;

  set navigator(AppNavigator<T> navigator) {
    _navigator = navigator;
  }

  MaterialPageRoute<T> buildRoute() =>
      _navigator.buildRoute(_path, _child);
}

