import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/utils/income_utils/income_utils.dart';

void main() {
  group('IncomeUtils Test', () {
    test(
        'Test that IncomeUtils.calculateTotalIncome returns correct '
        'total income', () {
      const income = <IncomeModel>[
        IncomeModel(
          id: '1',
          nameOfRevenue: 'Salary',
          amount: 100,
        ),
        IncomeModel(
          id: '2',
          nameOfRevenue: 'Savings',
          amount: 200,
        ),
      ];
      final totalIncome = IncomeUtils.calculateTotalIncome(income: income);
      expect(totalIncome, 300);
    });

    test(
        'Test that IncomeUtils.getHighestIncome returns correct highest income',
        () {
      const income = <IncomeModel>[
        IncomeModel(
          id: '1',
          nameOfRevenue: 'Salary',
          amount: 100,
        ),
        IncomeModel(
          id: '2',
          nameOfRevenue: 'Savings',
          amount: 200,
        ),
      ];
      final highestIncome = IncomeUtils.getHighestIncome(income: income);
      expect(highestIncome?.id, '2');
    });
  });
}
