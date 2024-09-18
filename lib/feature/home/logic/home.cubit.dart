import 'package:app/core/router/routebase.dart';
import 'package:app/feature/dashboard/helper/dashboard.route.dart';
import 'package:app/feature/quiz/helper/quiz.route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(_Dashboard());

  void showDashboard() => _goTo(_Dashboard());
  void showMyQuiz() => _goTo(_MyQuiz());
  void showCreateQuiz() => _goTo(_CreateQuiz());

  void back() {
    final last = state.previous;
    if (last != null) emit(last);
  }

  void _goTo<T extends HomeState>(T newState) {
    if (state is T) return;
    emit(newState);
  }
}
