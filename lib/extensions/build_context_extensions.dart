import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/widgets/app_dialog.dart';
import 'package:personal_expense_tracker/widgets/theme_picker_widget.dart';

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

  Future<ConfirmationDialogResult> showConfirmationDialog({
    required String message,
    String? title,
    bool barrierDismissible = true,
  }) async {
    final dialogResult = await showAdaptiveDialog<ConfirmationDialogResult?>(
      context: this,
      barrierDismissible: true,
      builder: (context) => ConfirmationDialogWidget(
        title: title ?? context.l10n.confirm,
        message: message,
      ),
    );
    return dialogResult ?? ConfirmationDialogResult.cancel;
  }

  Future<void> openThemePicker() async {
    await showModalBottomSheet<void>(
      context: this,
      barrierColor: Colors.black.withOpacity(0.3),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const ThemePickerWidget();
      },
    );
  }
}
