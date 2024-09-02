import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit'
    '/expenditure_cubit.dart';

void main() {
  group('Expenditure State Test', () {
    test('Test that ExpenditureState is instantiated with correct values', () {
      const expenditures = <ExpenditureModel>[];
      const errorMessage = 'error';
      const apiStatus = ApiStatus.loading;
      const incomeDeletionStatus = ApiStatus.success;
      const state = ExpenditureState(
        expenditures: expenditures,
        errorMessage: errorMessage,
        apiStatus: apiStatus,
        expenditureDeletionStatus: incomeDeletionStatus,
      );
      expect(state.expenditures, expenditures);
      expect(state.errorMessage, errorMessage);
      expect(state.apiStatus, apiStatus);
      expect(state.expenditureDeletionStatus, incomeDeletionStatus);
    });

    test(
        'Test that ExpenditureState of two different instances are equal '
        'when all attributes being equal are equal', () {
      const state1 = ExpenditureState(
        expenditures: [],
        errorMessage: 'error',
        apiStatus: ApiStatus.failure,
        expenditureDeletionStatus: ApiStatus.initial,
      );
      const state2 = ExpenditureState(
        expenditures: [],
        errorMessage: 'error',
        apiStatus: ApiStatus.failure,
        expenditureDeletionStatus: ApiStatus.initial,
      );
      expect(state1, state2);
    });
  });
}
