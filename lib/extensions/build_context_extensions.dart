import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension BuildContextExtensions on BuildContext {
  TextStyle? get displayLargeText => Theme.of(this).textTheme.displaySmall;
  TextStyle? get largeText => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get mediumText => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get smallText => Theme.of(this).textTheme.bodySmall;

  double? get deviceWidth => MediaQuery.sizeOf(this).width;

  Color get primaryColor => Theme.of(this).colorScheme.primary;

  void showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const Gap(10),
            Text(message),
          ],
        ),
      ),
    );
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          children: [
            const Icon(Icons.cancel_outlined, color: Colors.white),
            const Gap(10),
            Text(message),
          ],
        ),
      ),
    );
  }
}
