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
              child: Text(message, maxLines: 4),
            )
          ],
        ),
        duration: const Duration(seconds: 2),
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
            ),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
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
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.orange,
      ),
    );
  }


}
