// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:personal_expense_tracker/dtos/expenditure_response_dto.dart';

class ExpenditureModel extends Equatable {
  const ExpenditureModel({
    required this.id,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });

  final String id;
  final String category;
  final String nameOfItem;
  final double estimatedAmount;

  ExpenditureModel.fromExpenseResponseDto({required ExpenditureResponseDto dto})
      : this(
          id: dto.id,
          category: dto.category,
          nameOfItem: dto.nameOfItem,
          estimatedAmount: dto.estimatedAmount,
        );

  @override
  List<Object> get props => [id, category, nameOfItem, estimatedAmount];

  double calculatePercentage({required List<ExpenditureModel> expenditures}) {
    final total = expenditures.fold(
      0.toDouble(),
      (previousValue, element) => previousValue + element.estimatedAmount,
    );
    return (estimatedAmount / total) * 100;
  }
}
