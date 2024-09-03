import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/repositories/expenditure_repository.dart';

part 'expenditure_state.dart';

class ExpenditureCubit extends Cubit<ExpenditureState> {
  ExpenditureCubit({
    required ExpenditureRepository expenditureRepository,
  })  : _expenditureRepository = expenditureRepository,
        super(const ExpenditureState.initial());
  final ExpenditureRepository _expenditureRepository;

  Future<void> onLoadExpenditure() async {
    emit(const ExpenditureState.loading());
    try {
      final expenditures = await _expenditureRepository.getAllExpenditure();
      emit(ExpenditureState.success(expenditures: expenditures));
    } on ApiException catch (e) {
      emit(
        ExpenditureState.failed(errorMessage: e.message),
      );
    }
  }

  /// Returns a string containing an error when something went wrong
  /// while refreshing the expenditure.
  Future<String?> onRefreshExpenditure() async {
    try {
      final expenditures = await _expenditureRepository.getAllExpenditure();
      emit(ExpenditureState.success(expenditures: expenditures));
    } on ApiException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<String?> onDeleteExpenditure({
    required String id,
  }) async {
    try {
      emit(
        state.isDeletionInProgress(),
      );
      await _expenditureRepository.deleteExpenditure(
        id: id,
      );
      final existingExpenditures = [...state.expenditures];
      // ignore: cascade_invocations
      existingExpenditures.removeWhere((element) => element.id == id);
      emit(
        state.isDeletionSuccess(
          updatedExpenditures: existingExpenditures,
        ),
      );
    } on ApiException {
      emit(
        state.isDeletionFailure(),
      );
      return 'Something went wrong while deleting expenditure';
    }
    return null;
  }
}
