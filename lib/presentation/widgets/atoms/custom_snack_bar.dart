import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        required SnackBarType snackBarType,
      }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: snackBarType == SnackBarType.warning
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: _getSnackBarColor(context, snackBarType),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getSnackBarColor(BuildContext context, SnackBarType snackBarType) {
    switch (snackBarType) {
      case SnackBarType.error:
        return Theme.of(context).colorScheme.error;
      case SnackBarType.success:
        return Theme.of(context).colorScheme.primary;
      case SnackBarType.warning:
        return Theme.of(context).colorScheme.secondary;
    }
  }
}

enum SnackBarType { error, success, warning }
