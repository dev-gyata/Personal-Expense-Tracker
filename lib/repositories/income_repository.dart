import 'package:personal_expense_tracker/dtos/income_creation_request_dto.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/services/income_service.dart';

class IncomeRepository {
  IncomeRepository({
    required IncomeService incomeService,
  }) : _incomeService = incomeService;

  final IncomeService _incomeService;

  Future<List<IncomeModel>> getAllUserIncome() async {
    final rawIncome = await _incomeService.getUserIncome();
    return rawIncome
        .map((e) => IncomeModel.fromIncomeResponseDto(dto: e))
        .toList();
  }

  Future<void> createUserIncome({
    required String nameOfRevenue,
    required double amount,
  }) async {
    await _incomeService.createUserIncome(
      incomeRequestDto: IncomeCreationRequestDto(
        nameOfRevenue: nameOfRevenue,
        amount: amount,
      ),
    );
  }

  Future<String> deleteUserIncome({
    required String id,
  }) async {
    final response = await _incomeService.deleteUserIncome(
      incomeId: id,
    );
    return response.id;
  }
}
