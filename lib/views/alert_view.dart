import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AlertView extends StatelessWidget {
  const AlertView({super.key, required this.message});

  final String message;

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Error'),
      content: Text(message),
      actions: [
         adaptiveAction(
              context: context,
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
        ],

    );
  }
}