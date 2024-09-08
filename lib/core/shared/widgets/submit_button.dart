import 'package:app/core/theme/colors.dart';
import 'package:app/core/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final Future<void> Function() onPressed;
  final String title;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await widget.onPressed();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(color: AppColors.white)
              : AppText.h3(widget.title, color: AppColors.white),
        ),
      ),
    );
  }
}
