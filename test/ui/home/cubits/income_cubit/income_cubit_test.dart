import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';

class MockIncomeRepository extends Mock implements IncomeRepository {}

void main() {
  group('IncomeCubit Test', () {
    late IncomeCubit incomeCubit;
    late MockIncomeRepository mockIncomeRepository;
    setUp(() {
      mockIncomeRepository = MockIncomeRepository();
      incomeCubit = IncomeCubit(
        incomeRepository: mockIncomeRepository,
      );
    });
    blocTest<IncomeCubit, IncomeState>(
      'Test That cubit state  Changes to sucess when income '
      'repository returns list of income',
      build: () => incomeCubit,
      act: (cubit) {
        cubit.onLoadIncome();
      },
      setUp: () {
        when(mockIncomeRepository.getAllUserIncome).thenAnswer((_) async {
          return [
            const IncomeModel(
              id: '1',
              nameOfRevenue: 'Salary',
              amount: 500,
            ),
            const IncomeModel(
              id: '2',
              nameOfRevenue: 'Savings',
              amount: 500,
            ),
          ];
        });
      },
      expect: () => [
        const IncomeState.loading(),
        const IncomeState.success(
          income: [
            IncomeModel(
              id: '1',
              nameOfRevenue: 'Salary',
              amount: 500,
            ),
            IncomeModel(
              id: '2',
              nameOfRevenue: 'Savings',
              amount: 500,
            ),
          ],
        ),
      ],
    );
    blocTest<IncomeCubit, IncomeState>(
      'Test That cubit state changes to failure when income '
      'repository throws an api exception',
      build: () => incomeCubit,
      act: (cubit) {
        cubit.onLoadIncome();
      },
      setUp: () {
        when(mockIncomeRepository.getAllUserIncome).thenThrow(
          ApiException(message: 'Unable to fetch user income'),
        );
      },
      expect: () => [
        const IncomeState.loading(),
        const IncomeState.failed(
          errorMessage: 'Unable to fetch user income',
        ),
      ],
    );

    blocTest<IncomeCubit, IncomeState>(
      'Test That cubit state changes to sucess without moving to loading when'
      ' income repository returns list of income with refresh '
      'income method call',
      build: () => incomeCubit,
      act: (cubit) {
        cubit.onRefreshIncome();
      },
      setUp: () {
        when(mockIncomeRepository.getAllUserIncome).thenAnswer((_) async {
          return [
            const IncomeModel(
              id: '1',
              nameOfRevenue: 'Salary',
              amount: 500,
            ),
            const IncomeModel(
              id: '2',
              nameOfRevenue: 'Savings',
              amount: 500,
            ),
          ];
        });
      },
      expect: () => [
        const IncomeState.success(
          income: [
            IncomeModel(
              id: '1',
              nameOfRevenue: 'Salary',
              amount: 500,
            ),
            IncomeModel(
              id: '2',
              nameOfRevenue: 'Savings',
              amount: 500,
            ),
          ],
        ),
      ],
    );
    blocTest<IncomeCubit, IncomeState>(
      'Test That cubit state doesnt change when'
      ' income repository throws an api exception with refresh '
      'income method call',
      build: () => incomeCubit,
      act: (cubit) {
        cubit.onRefreshIncome();
      },
      setUp: () {
        when(mockIncomeRepository.getAllUserIncome).thenThrow(
          ApiException(message: 'Unable to fetch user income'),
        );
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => const [],
    );
  });
}
