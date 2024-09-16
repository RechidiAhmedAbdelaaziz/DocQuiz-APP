import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinedText extends StatelessWidget {
  const LinedText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 6.h,
            color: Colors.blue,
          ),
        ),
        Text(
          text,
          style: style?.copyWith(
            height: 1.1,
          ),
        ),
      ],
    );
  }
}
