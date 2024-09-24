import 'package:app/core/router/routebase.dart';
import 'package:app/feature/dashboard/helper/dashboard.route.dart';
import 'package:app/feature/exam/helper/exam.route.dart';
import 'package:app/feature/playlist/helper/playlist.route.dart';
import 'package:app/feature/quiz/helper/quiz.route.dart';
import 'package:app/feature/user/helper/user.route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(_Dashboard());

  void showDashboard() => _goTo(_Dashboard());
  void showMyQuiz() => _goTo(_MyQuiz());
  void showCreateQuiz() => _goTo(_CreateQuiz());
  void showPlayList() => _goTo(_PlayList());
  void showExam() => _goTo(_Exam());
  void showProfile() => _goTo(_Profile());

  void refresh() {
    emit(_Loading());
    Future.delayed(const Duration(milliseconds: 500), () {
      back();
    });
  }

  void back() {
    final last = state.previous;
    if (last != null) emit(last);
  }

  void _goTo<T extends HomeState>(T newState,
      {bool refresh = false}) {
    if (state is T && !refresh) return;
    emit(newState);
  }
}
