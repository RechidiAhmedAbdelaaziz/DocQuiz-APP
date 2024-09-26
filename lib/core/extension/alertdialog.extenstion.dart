import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';

extension AlertDialogExtension on BuildContext {
  Future<T?> showDialogBox<T>({
    required String title,
    String body = '',
    Widget? content,
    String? confirmText,
    void Function(VoidCallback)? onConfirm,
    String? cancelText,
    void Function(VoidCallback)? onCancel,
    bool canPop = true,
  }) async {
    return showDialog<T>(
      context: this,
      builder: (context) {
        return PopScope(
          canPop: canPop,
          child: AlertDialog(
            backgroundColor: context.colors.background,
            title: Text(
              title,
              style: context.textStyles.h3,
            ),
            content: content ??
                Text(body, style: context.textStyles.body1),
            actions: <Widget>[
              if (cancelText != null)
                TextButton(
                  onPressed: () {
                    if (onCancel != null) onCancel(context.back);
                  },
                  child: Text(
                    cancelText,
                    style: context.textStyles.h5
                        .copyWith(color: Colors.red),
                  ),
                ),
              if (confirmText != null)
                TextButton(
                  onPressed: () {
                    if (onConfirm != null) onConfirm(context.back);
                  },
                  child: Text(
                    confirmText,
                    style: context.textStyles.h5
                        .copyWith(color: Colors.teal),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<T?> showPopUp<T>({
    required Widget content,
  }) async {
    return showDialog<T>(
      context: this,
      builder: (context) {
        return content;
      },
    );
  }
}
