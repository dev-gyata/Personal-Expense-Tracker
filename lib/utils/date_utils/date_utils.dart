import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

enum CurrentTime {
  morning,
  afternoon,
  evening;

  String formatTime(BuildContext context) {
    return switch (this) {
      CurrentTime.morning => context.l10n.goodMorning,
      CurrentTime.afternoon => context.l10n.goodAfternoon,
      CurrentTime.evening => context.l10n.goodEvening,
    };
  }
}

class CurrentTimeUtils {
  static CurrentTime getCurrentTime({
    required DateTime date,
  }) {
    final hour = date.hour;

    if (hour >= 5 && hour < 12) {
      return CurrentTime.morning;
    } else if (hour >= 12 && hour < 17) {
      return CurrentTime.afternoon;
    } else {
      return CurrentTime.evening;
    }
  }
}
