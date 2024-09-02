import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

extension ThemeModeExtensions on ThemeMode {
  String getThemeName(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.l10n.systemTheme;
      case ThemeMode.light:
        return context.l10n.lightTheme;
      case ThemeMode.dark:
        return context.l10n.darkTheme;
    }
  }
}
