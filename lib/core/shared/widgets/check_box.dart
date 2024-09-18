import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    required this.value,
    required this.onChange,
    required this.title,
    this.padding = const EdgeInsets.only(),
  });

  final bool value;
  final ValueChanged<bool> onChange;
  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          InkWell(
            onTap: () => onChange(!value),
            child: Icon(
              value ? Icons.check_box : Icons.check_box_outline_blank,
              color: context.colors.dark,
              size: 27.sp,
            ),
          ),
          width(5),
          Text(
            title,
            style: context.textStyles.body1.copyWith(
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
