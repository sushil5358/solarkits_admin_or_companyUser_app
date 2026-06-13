// import 'package:flutter/material.dart';
//
// void showCustomSnackBar(
//   BuildContext context, {
//   required String message,
//   Duration duration = const Duration(seconds: 2),
//   required Color backgroundColor,
// }) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       duration: duration,
//       content: Text(message),
//       backgroundColor: backgroundColor,
//       margin: EdgeInsets.all(40),
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//     ),
//   );
// }


import 'package:flutter/material.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      Duration duration = const Duration(seconds: 2),
      required Color backgroundColor,
      bool checkMounted = true, // Optional: caller can disable mounted check
    }) {
  // Optionally check if the calling widget is still mounted
  if (checkMounted) {
    try {
      // Try to check if the widget is still in the tree
      final element = context as Element;
      if (!element.mounted) {
        debugPrint('Widget not mounted - skipping snackbar: $message');
        return;
      }
    } catch (e) {
      // If we can't check mounted, proceed anyway
    }
  }

  // Use maybeOf to safely get ScaffoldMessenger
  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);

  if (scaffoldMessenger == null) {
    debugPrint('Cannot show snackbar - no ScaffoldMessenger found');
    return;
  }

  // Use a post-frame callback for extra safety
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final currentScaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    if (currentScaffoldMessenger != null) {
      currentScaffoldMessenger.showSnackBar(
        SnackBar(
          duration: duration,
          content: Text(message),
          backgroundColor: backgroundColor,
          margin: EdgeInsets.all(40),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      );
    }
  });
}