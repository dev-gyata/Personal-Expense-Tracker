import 'package:personal_expense_tracker/models/models.dart';

class IncomeUtils {
  static double calculateTotalIncome({required List<IncomeModel> income}) {
    return income.fold(
      0.toDouble(),
      (previousValue, element) => previousValue + element.amount,
    );
  }

  static IncomeModel? getHighestIncome({required List<IncomeModel> income}) {
    if (income.isEmpty) {
      return null;
    }
    IncomeModel? highestIncome;
    for (final income in income) {
      if (highestIncome == null || income.amount > highestIncome.amount) {
        highestIncome = income;
      }
    }
    return highestIncome;
  }
}
