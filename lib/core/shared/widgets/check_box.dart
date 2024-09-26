import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    this.value,
    required this.onChange,
    required this.title,
    this.padding = const EdgeInsets.only(),
  }) : canSelect = value != null;

  final bool canSelect;
  final bool? value;
  final ValueChanged<bool> onChange;
  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(canSelect ? !value! : true),
      child: Row(
        children: [
          Icon(
            !canSelect
                ? Icons.arrow_forward_ios_rounded
                : value!
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
            color: context.colors.dark,
            size: canSelect ? 25.sp : 20.sp,
          ),
          width(5),
          Text(
            title,
            style: context.textStyles.body1.copyWith(
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}
