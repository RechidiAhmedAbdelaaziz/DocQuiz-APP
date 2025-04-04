// ignore_for_file: library_private_types_in_public_api

import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputeField extends StatefulWidget {
  const AppInputeField({
    super.key,
    String? hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  })  : _hint = hint,
        _controller = controller,
        _keyboardType = keyboardType,
        _obscureText = obscureText,
        _onChanged = onChanged,
        _validator = validator;

  final String? _hint;
  final TextEditingController _controller;
  final TextInputType _keyboardType;
  final bool _obscureText;
  final void Function(String)? _onChanged;
  final String? Function(String?)? _validator;

  @override
  _AppInputeFieldState createState() => _AppInputeFieldState();
}

class _AppInputeFieldState extends State<AppInputeField> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 700, maxHeight: 170.h),
      child: TextFormField(
        controller: widget._controller,
        keyboardType: widget._keyboardType,
        obscureText: widget._obscureText && !_showContent,
        onChanged: widget._onChanged,
        validator: widget._validator,
        maxLines: widget._keyboardType == TextInputType.multiline
            ? null
            : 1,
        style: context.theme.textStyles.body1,
        decoration: InputDecoration(
          hintText: widget._hint,
          hintStyle: context.theme.textStyles.body2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:
                BorderSide(color: context.theme.colors.primary),
          ),
          isDense: true,
          isCollapsed: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          suffixIcon: widget._obscureText
              ? IconButton(
                  icon: Icon(
                    _showContent
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: context.theme.colors.primaryText,
                  ),
                  onPressed: () {
                    setState(() {
                      _showContent = !_showContent;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
