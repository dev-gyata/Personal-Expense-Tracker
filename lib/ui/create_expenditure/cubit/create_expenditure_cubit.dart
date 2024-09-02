import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/expenditure_repository.dart';

part 'create_expenditure_state.dart';

class CreateExpenditureCubit extends Cubit<CreateExpenditureState> {
  CreateExpenditureCubit({
    required ExpenditureRepository expenditureRepository,
  })  : _expenditureRepository = expenditureRepository,
        super(const CreateExpenditureState.initial());

  final ExpenditureRepository _expenditureRepository;

  void onCategoryChanged(String category) {
    final updatedCategory = TextInputModel.dirty(category);
    emit(
      state.copyWith(
        category: updatedCategory,
      ),
    );
  }

  void onNameOfItemChanged(String nameOfItem) {
    final updatedNameOfItem = TextInputModel.dirty(nameOfItem);
    emit(
      state.copyWith(
        nameOfItem: updatedNameOfItem,
      ),
    );
  }

  void onEstimatedAmountChanged(String estimatedAmount) {
    final updatedEstimatedAmount = AmountModel.dirty(estimatedAmount);
    emit(
      state.copyWith(
        estimatedAmount: updatedEstimatedAmount,
      ),
    );
  }

  Future<void> onSubmit() async {
    if (state.isFormValid) {
      emit(state.loading());
      try {
        await _expenditureRepository.createExpenditure(
          nameOfItem: state.nameOfItem.value,
          estimatedAmount: double.tryParse(state.estimatedAmount.value) ?? 0.0,
          category: state.category.value,
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
