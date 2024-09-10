import 'package:app/feature/auth/module/login/ui/login.screen.dart';
import 'package:app/feature/dashboard/widget/dashboard.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home.state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(_Dashboard());

  void showDashboard() => emit(_Dashboard());
  void showSettings() => emit(_Settings());
}
