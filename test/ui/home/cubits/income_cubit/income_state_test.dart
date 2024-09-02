import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';

void main() {
  group('Income State Test', () {
    test('Test that IncomeState is instantiated with correct values', () {
      const income = <IncomeModel>[];
      const errorMessage = 'error';
      const apiStatus = ApiStatus.loading;
      const incomeDeletionStatus = ApiStatus.success;
      const state = IncomeState(
        income: income,
        errorMessage: errorMessage,
        apiStatus: apiStatus,
        incomeDeletionStatus: incomeDeletionStatus,
      );
      expect(state.income, income);
      expect(state.errorMessage, errorMessage);
      expect(state.apiStatus, apiStatus);
      expect(state.incomeDeletionStatus, incomeDeletionStatus);
    });

    test(
        'Test that IncomeState of two different instances are equal '
        'when all attributes being equal are equal', () {
      const state1 = IncomeState(
        income: [],
        errorMessage: 'error',
        apiStatus: ApiStatus.failure,
        incomeDeletionStatus: ApiStatus.initial,
      );
      const state2 = IncomeState(
        income: [],
        errorMessage: 'error',
        apiStatus: ApiStatus.failure,
        incomeDeletionStatus: ApiStatus.initial,
      );
      expect(state1, state2);
    });
  });
}
