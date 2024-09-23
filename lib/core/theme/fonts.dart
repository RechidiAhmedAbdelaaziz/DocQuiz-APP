import 'package:app/core/di/container.dart';
import 'package:app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontStyles {
  final Color primary = locator<AppColors>().primaryText;
  final Color secondary = locator<AppColors>().secondaryText;

  TextStyle get h1 => TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: primary,
      );

  TextStyle get h2 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      );

  TextStyle get h3 => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: primary,
      );

  TextStyle get h4 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: primary,
      );

  TextStyle get h5 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: primary,
      );

  TextStyle get body1 => TextStyle(
        fontSize: 16.sp,
        color: primary,
        fontWeight: FontWeight.w600,
      );

  TextStyle get body2 => TextStyle(
        fontSize: 14.sp,
        color: primary,
      );

  TextStyle get caption => TextStyle(
        fontSize: 12.sp,
        color: secondary,
      );
}
// regex to replace number XXX with 00.sp
// \b(\d{2})\b
// $1.sp