import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BottomSheet on BuildContext {
  Future<T?> showBottomSheet<T>({
    required Widget child,
  }) async {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 100.h),
            padding: EdgeInsets.symmetric(
                horizontal: 22.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 45.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
