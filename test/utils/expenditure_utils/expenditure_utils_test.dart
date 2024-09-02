import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/category_model.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/utils/expenditure_utils/expenditure_utils.dart';

void main() {
  group('ExpenditureUtils Test', () {
    test(
        'Test that ExpenditureUtils.foldExpendituresIntoCategories '
        'returns correct list of ExpenditureModel', () {
      const expenditures = <ExpenditureModel>[
        ExpenditureModel(
          id: '1',
          category: 'transport',
          nameOfItem: 'transport',
          estimatedAmount: 500,
        ),
        ExpenditureModel(
          id: '2',
          category: 'transport',
          nameOfItem: 'transport',
          estimatedAmount: 500,
        ),
      ];
      final expendituresByCategory =
          ExpenditureUtils.foldExpendituresIntoCategories(expenditures);
      expect(expendituresByCategory.length, 1);
      expect(expendituresByCategory, <CategoryModel>[
        const CategoryModel(
          name: 'transport',
          amount: 1000,
          expenditures: [
            ExpenditureModel(
              id: '1',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
            ExpenditureModel(
              id: '2',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
          ],
        ),
      ]);
    });
  });
}
