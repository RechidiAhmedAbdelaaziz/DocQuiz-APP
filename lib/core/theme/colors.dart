// ignore_for_file: prefer_final_fields, annotate_overrides

import 'package:flutter/material.dart';

abstract class AppColors {
  final Color background;
  final Color primary;
  final Color primaryText;
  final Color secondaryText;

  AppColors({
    required this.background,
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
  });
}

class LightColors implements AppColors {
  final Color background = const Color(0xFFf1f5f9);
  final Color primary = const Color(0xFF3f72af);
  final Color primaryText = const Color(0xFF1a1a1a);
  final Color secondaryText = const Color(0xFFa1a1a1);
}

class DarkColors implements AppColors {
  final Color background = const Color(0xFF1a1a1a);
  final Color primary = const Color(0xFF3f72af);
  final Color primaryText = const Color(0xFFf1f5f9);
  final Color secondaryText = const Color(0xFFa1a1a1);
}
