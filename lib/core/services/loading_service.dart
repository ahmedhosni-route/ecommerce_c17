import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  static bool _isLoading = false;

  static void show(BuildContext context) {
    if (_isLoading) return;
    _isLoading = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent,
            ),
          ),
        );
      },
    ).then(
      (value) {
        _isLoading = false;
      },
    );
  }

  static void hide(BuildContext context) {
    if (_isLoading) {
      Navigator.pop(context);
      _isLoading = false;
    }
  }
}
