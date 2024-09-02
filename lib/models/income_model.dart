import 'package:equatable/equatable.dart';
import 'package:personal_expense_tracker/dtos/income_response_dto.dart';

class IncomeModel extends Equatable {
  const IncomeModel({
    required this.id,
    required this.nameOfRevenue,
    required this.amount,
  });

  IncomeModel.fromIncomeResponseDto({required IncomeResponseDto dto})
      : this(
          id: dto.id,
          nameOfRevenue: dto.nameOfRevenue,
          amount: dto.amount,
        );
  final String id;
  final String nameOfRevenue;
  final double amount;

  IncomeModel copyWith({
    String? id,
    String? nameOfRevenue,
    double? amount,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      nameOfRevenue: nameOfRevenue ?? this.nameOfRevenue,
      amount: amount ?? this.amount,
    );
  }

  double calculatePercentage({
    required List<IncomeModel> allIncome,
  }) {
    final total = allIncome.fold(
      0.toDouble(),
      (previousValue, element) => previousValue + element.amount,
    );
    return (amount / total) * 100;
  }

  @override
  List<Object> get props => [id, nameOfRevenue, amount];
}
