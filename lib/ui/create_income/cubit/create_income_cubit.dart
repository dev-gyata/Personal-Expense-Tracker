import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';

part 'create_income_state.dart';

class CreateIncomeCubit extends Cubit<CreateIncomeState> {
  CreateIncomeCubit({
    required IncomeRepository incomeRepository,
  })  : _incomeRepository = incomeRepository,
        super(const CreateIncomeState.initial());

  final IncomeRepository _incomeRepository;

  void onNameOfRevenueChanged(String nameOfRevenue) {
    final updatedNameOfRevenue = TextInputModel.dirty(nameOfRevenue);
    emit(
      state.copyWith(
        nameOfRevenue: updatedNameOfRevenue,
      ),
    );
  }

  void onAmountChanged(String amount) {
    final updatedAmount = AmountModel.dirty(amount);
    emit(
      state.copyWith(
        amount: updatedAmount,
      ),
    );
  }

  Future<void> onSubmit() async {
    if (state.isFormValid) {
      emit(state.loading());
      try {
        await _incomeRepository.createUserIncome(
          amount: double.tryParse(state.amount.value) ?? 0.0,
          nameOfRevenue: state.nameOfRevenue.value,
        );
        emit(state.success());
      } on ApiException catch (e) {
        emit(
          state.failed(errorMessage: e.message),
        );
      }
    }
  }
}
