import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinedText extends StatelessWidget {
  const LinedText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(12),
          Text.rich(
            TextSpan(
              text: text[0],
              style: style ??
                  context.textStyles.h2.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
              children: [
                TextSpan(
                  text: text.substring(1),
                  style: (style ?? context.textStyles.h2).copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    );
  }
}
