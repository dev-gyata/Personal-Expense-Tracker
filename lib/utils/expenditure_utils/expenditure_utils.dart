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
        expenditures.groupListsBy((e) => e.category.toLowerCase());
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
}
