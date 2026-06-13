import 'package:flutter/material.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      Duration duration = const Duration(seconds: 2),
      required Color backgroundColor,
    }) {
  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null) return;

  scaffoldMessenger.showSnackBar(
    SnackBar(
      duration: duration,
      content: Text(message),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(40),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}