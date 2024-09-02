import 'package:equatable/equatable.dart';

import 'package:personal_expense_tracker/models/models.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.name,
    required this.amount,
    required this.expenditures,
  });
  final String name;
  final double amount;
  final List<ExpenditureModel> expenditures;

  CategoryModel copyWith({
    String? name,
    double? amount,
    List<ExpenditureModel>? expenditures,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      expenditures: expenditures ?? this.expenditures,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, amount, expenditures];

  double calculatePercentage({required List<CategoryModel> expenditures}) {
    final total = expenditures.fold(
      0.toDouble(),
      (previousValue, element) => previousValue + element.amount,
    );
    return (amount / total) * 100;
  }
}
