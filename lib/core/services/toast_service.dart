import 'package:flutter/material.dart';

class Toast {
  static showToast(
      {ToastType type = ToastType.success,
      required BuildContext context,
      required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              border: Border.all(
                  color: type == ToastType.success ? Colors.green : Colors.red),
              borderRadius: BorderRadius.circular(16),
              color: type == ToastType.success
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3)),
          child: Row(
            children: [
              type == ToastType.success
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
              const SizedBox(
                width: 8,
              ),
              Text(
                message,
                style: TextStyle(
                    color:
                        type == ToastType.success ? Colors.green : Colors.red),
              ),
            ],
          ),
        )));
  }
}

enum ToastType { success, error }
