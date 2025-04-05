// ignore_for_file: prefer_final_fields, annotate_overrides

import 'package:flutter/material.dart';

abstract class AppColors {
  final Color background;
  final Color primary;
  final Color primaryText;
  final Color secondaryText;
  final Color dark;

  AppColors({
    required this.background,
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.dark,
  });
}

class LightColors implements AppColors {
  final Color background = const Color(0xFFeff4fb);
  final Color primary = const Color(0xFFFFFFFF);
  final Color primaryText = const Color(0xFF1c2447);
  final Color secondaryText = const Color(0xFFa1a1a1);
  final Color dark = const Color(0xFF1c2447);
}

class DarkColors implements AppColors {
  final Color background = const Color(0xFF1d2a39);
  final Color primary = const Color(0xFF313d4a);
  final Color primaryText = const Color(0xFFf1f5f9);
  final Color secondaryText = const Color(0xFFa1a1a1);
  final Color dark = const Color(0xFFf1f5f9);
}
