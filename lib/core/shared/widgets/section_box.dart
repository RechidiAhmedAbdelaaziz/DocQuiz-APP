import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionBox extends StatelessWidget {
  const SectionBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: context.theme.colors.primary,
        border: Border.all(
            color: context.theme.colors.dark.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.dark.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: child,
    );
  }
}
