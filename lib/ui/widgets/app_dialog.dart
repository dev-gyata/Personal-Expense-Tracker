import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

enum ConfirmationDialogResult { cancel, ok }

class ConfirmationDialogWidget extends StatelessWidget {
  const ConfirmationDialogWidget({
    required this.title,
    required this.message,
    super.key,
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog.adaptive(
      title: Text(title),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(),
          ),
          onPressed: () {
            AutoRouter.of(context).maybePop(ConfirmationDialogResult.cancel);
          },
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            AutoRouter.of(context).maybePop(ConfirmationDialogResult.ok);
          },
          child: Text(l10n.ok),
        ),
      ],
      content: Text(message),
    );
  }
}
