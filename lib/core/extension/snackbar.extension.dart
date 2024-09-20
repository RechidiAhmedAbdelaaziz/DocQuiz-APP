import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                maxLines: 4,
                style: textStyles.h5.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        duration: const Duration(microseconds: 500, seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              maxLines: 4,
              style: textStyles.h5.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        duration: const Duration(microseconds: 500, seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showWarningSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              message,
              maxLines: 4,
              style: textStyles.h5.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        duration: const Duration(microseconds: 500, seconds: 1),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
