import 'package:app/core/router/abstract_route.dart';
import 'package:app/core/router/navigator.dart';
import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  /// Navigate to a named route with the provided AbstractRoute
  Future<T?> to<T>(RouteBase<T> route, {bool canPop = true}) async {
    if (!canPop) route.navigator = NoPopNavigator<T>();

    return await _tryNavigate<T>(() => Navigator.of(this)
        .pushNamed<T>(route.path, arguments: route));

       
      
  }

  /// Navigate to a named route and replace the current route
  Future<T?> off<T, TO>(RouteBase route,
      {TO? result, bool canPop = true}) {
    if (!canPop) route.navigator = NoPopNavigator<T>();
    return _tryNavigate(() {
      return Navigator.of(this).pushReplacementNamed<T, TO>(
        route.path,
        arguments: route,
        result: result,
      );
    });
  }

  /// Navigate to a named route and remove all previous routes until a condition is met
  Future<T?> offAll<T>(RouteBase route,
      {bool Function(Route<dynamic>)? predicate}) {
    return _tryNavigate(() {
      return Navigator.of(this).pushNamedAndRemoveUntil<T>(
        route.path,
        predicate ?? (Route<dynamic> r) => false,
        arguments: route,
      );
    });
  }

  /// Pop the current route off the navigator stack
  void back<T>([T? result]) {
    if (!Navigator.of(this).canPop()) return;
    Navigator.of(this).pop<T>(result);
  }

  /// Pop routes until the root route is reached
  void backToRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  /// Pop routes until a specific named route is reached
  void backTo(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }

  Future<T?> _tryNavigate<T>(Future<T?> Function() navigate) {
    try {
      return navigate();
    } catch (e) {
      debugPrint('Failed to navigate: $e');
      return Future.value(null);
    }
  }
}
