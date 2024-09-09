import 'package:app/core/di/container.dart';
import 'package:app/core/theme/colors.dart';
import 'package:app/core/theme/fonts.dart';
import 'package:flutter/material.dart';

extension AppTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeManager on ThemeData {
  AppColors get colors => locator<AppColors>();
  AppFontStyles get textStyles => locator<AppFontStyles>();
}
