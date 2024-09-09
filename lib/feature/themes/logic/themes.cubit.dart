import 'package:app/core/di/container.dart';
import 'package:app/core/theme/colors.dart';
import 'package:app/core/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'themes.state.dart';

class ThemesCubit extends Cubit<ThemesState> {
  ThemesCubit() : super(_LightTheme());

  void toggleTheme() {
    if (state is _LightTheme) {
      locator.registerSingleton<AppColors>(DarkColors());
      locator.registerSingleton(AppFontStyles());
      emit(_DarkTheme());
    } else {
      locator.registerSingleton<AppColors>(LightColors());
      locator.registerSingleton(AppFontStyles());
      emit(_LightTheme());
    }
  }
}
