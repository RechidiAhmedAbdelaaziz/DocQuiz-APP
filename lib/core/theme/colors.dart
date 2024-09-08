// ignore_for_file: prefer_final_fields, annotate_overrides

import 'dart:ui';

Color backgroundColor = const Color(0xFFf1f5f9);

abstract class AppColors {
  static Color get dark => const Color(0xFF1C2447);
  static Color get background => backgroundColor;
  static Color get primary =>
      const Color.fromARGB(255, 191, 184, 230);
  static Color get blue => const Color(0xFF3F51B5);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get grey => const Color(0xFF9E9E9E);
}
