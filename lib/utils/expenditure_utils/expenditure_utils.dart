import 'package:collection/collection.dart';
import 'package:personal_expense_tracker/models/category_model.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';

class ExpenditureUtils {
  // Group expenditures by category
  /// Returns a list of [CategoryModel] grouped by category
  static List<CategoryModel> foldExpendituresIntoCategories(
    List<ExpenditureModel> expenditures,
  ) {
    final expendituresByCategoryMap =
        expenditures.groupListsBy((e) => e.category.trim().toLowerCase());
    final expendituresByCategory = expendituresByCategoryMap.entries.map((e) {
      final category = e.key;
      final expenditures = e.value;
      final totalAmountInCategory = expenditures.fold(
        0.toDouble(),
        (previousValue, element) => previousValue + element.estimatedAmount,
      );
      return CategoryModel(
        name: category,
        amount: totalAmountInCategory,
        expenditures: expenditures,
      );
    });
    return expendituresByCategory.toList();
  }

  static double calculateTotalIncome({
    required List<ExpenditureModel> expenditures,
  }) {
    return expenditures.fold(
      0.toDouble(),
      (previousValue, element) => previousValue + element.estimatedAmount,
    );
  }

  static ExpenditureModel? getHighest({
    required List<ExpenditureModel> expenditures,
  }) {
    if (expenditures.isEmpty) {
      return null;
    }
    ExpenditureModel? highestExpenditure;
    for (final expenditure in expenditures) {
      if (highestExpenditure == null ||
          expenditure.estimatedAmount > highestExpenditure.estimatedAmount) {
        highestExpenditure = expenditure;
      }
    }
    return highestExpenditure;
  }

  static CategoryModel? getHighestCategory({
    required List<ExpenditureModel> expenditures,
  }) {
    if (expenditures.isEmpty) {
      return null;
    }
    final categories = foldExpendituresIntoCategories(expenditures);
    CategoryModel? highestCategory;
    for (final category in categories) {
      if (highestCategory == null || category.amount > highestCategory.amount) {
        highestCategory = category;
      }
    }
    return highestCategory;
  }
}
