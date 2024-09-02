import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit({
    required IncomeRepository incomeRepository,
  })  : _incomeRepository = incomeRepository,
        super(const IncomeState.initial());

  final IncomeRepository _incomeRepository;

  Future<void> onLoadIncome() async {
    emit(const IncomeState.loading());
    try {
      final income = await _incomeRepository.getAllUserIncome();
      emit(IncomeState.success(income: income));
    } on ApiException catch (e) {
      emit(
        IncomeState.failed(errorMessage: e.message),
      );
    }
  }

  Future<void> onDeleteExpenditure({
    required String id,
  }) async {
    try {
      emit(
        state.isDeletionInProgress(),
      );
      await _incomeRepository.deleteUserIncome(
        id: id,
      );
      final existingIncome = [...state.income];
      // ignore: cascade_invocations
      existingIncome.removeWhere((element) => element.id == id);
      emit(
        state.isDeletionSuccess(
          updatedIncome: existingIncome,
        ),
      );
    } on ApiException catch (_) {
      emit(
        state.isDeletionFailure(),
      );
    }
  }
}
