import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/resources/resources.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    required this.errorMessage,
    required this.onRetry,
    super.key,
  });
  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(Animations.errorStateAnimation),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
        TextButton(onPressed: onRetry, child: Text(l10n.tapHereToRetry)),
      ],
    );
  }
}
