import 'package:personal_expense_tracker/dtos/expenditure_creation_request_dto.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/services/expenditure_service.dart';

class ExpenditureRepository {
  const ExpenditureRepository({
    required ExpenditureService expenditureService,
  }) : _expenditureService = expenditureService;

  final ExpenditureService _expenditureService;

  Future<void> createExpenditure({
    required String nameOfItem,
    required double estimatedAmount,
    required String category,
  }) async {
    return _expenditureService.createUserExpenditure(
      creationRequestDto: ExpenditureCreationRequestDto(
        nameOfItem: nameOfItem,
        estimatedAmount: estimatedAmount,
        category: category,
      ),
    );
  }

  Future<List<ExpenditureModel>> getAllExpenditure() async {
    final rawExpenditures = await _expenditureService.getUserExpenditure();
    return rawExpenditures
        .map((e) => ExpenditureModel.fromExpenseResponseDto(dto: e))
        .toList();
  }

  Future<String> deleteExpenditure({
    required String id,
  }) async {
    final deletedExpenditure = await _expenditureService.deleteUserExpenditure(
      expenditureId: id,
    );
    return deletedExpenditure.id;
  }
}
