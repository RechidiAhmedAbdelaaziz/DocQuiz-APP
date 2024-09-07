import 'package:app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends Text {
  AppText.h2(super.data, {super.key, Color? color})
      : super(
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: color ?? AppColors.dark,
          ),
        );

  AppText.h3(super.data, {super.key, Color? color})
      : super(
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: color ?? AppColors.dark,
          ),
        );

  AppText.body(super.data, {super.key, Color? color})
      : super(
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: color ?? AppColors.dark,
          ),
        );

  AppText.label(super.data, {super.key})
      : super(
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        );
}
