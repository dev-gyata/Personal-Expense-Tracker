import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/repositories/expenditure_repository.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';

class MockExpenditureRepository extends Mock implements ExpenditureRepository {}

void main() {
  group('ExpenditureCubit Test', () {
    late ExpenditureCubit expenditureCubit;
    late MockExpenditureRepository mockExpenditureRepository;
    setUp(() {
      mockExpenditureRepository = MockExpenditureRepository();
      expenditureCubit = ExpenditureCubit(
        expenditureRepository: mockExpenditureRepository,
      );
    });
    blocTest<ExpenditureCubit, ExpenditureState>(
      'Test That cubit state  Changes to sucess when expenditure '
      'repository returns list of expenditures',
      build: () => expenditureCubit,
      act: (cubit) {
        cubit.onLoadExpenditure();
      },
      setUp: () {
        when(() => mockExpenditureRepository.getAllExpenditure())
            .thenAnswer((_) async {
          return [
            const ExpenditureModel(
              id: '1',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
            const ExpenditureModel(
              id: '2',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
          ];
        });
      },
      expect: () => [
        const ExpenditureState.loading(),
        const ExpenditureState.success(
          expenditures: [
            ExpenditureModel(
              id: '1',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
            ExpenditureModel(
              id: '2',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
          ],
        ),
      ],
    );
    blocTest<ExpenditureCubit, ExpenditureState>(
      'Test That cubit state changes to failure when expenditure '
      'repository throws an api exception',
      build: () => expenditureCubit,
      act: (cubit) {
        cubit.onLoadExpenditure();
      },
      setUp: () {
        when(() => mockExpenditureRepository.getAllExpenditure()).thenThrow(
          ApiException(message: 'Unable to fetch user Expenditure'),
        );
      },
      expect: () => [
        const ExpenditureState.loading(),
        const ExpenditureState.failed(
          errorMessage: 'Unable to fetch user Expenditure',
        ),
      ],
    );

    blocTest<ExpenditureCubit, ExpenditureState>(
      'Test That cubit state changes to sucess without moving to loading when'
      ' expenditure when repository returns list of expenditures with refresh '
      'expenditure method call',
      build: () => expenditureCubit,
      act: (cubit) {
        cubit.onRefreshExpenditure();
      },
      setUp: () {
        when(() => mockExpenditureRepository.getAllExpenditure())
            .thenAnswer((_) async {
          return [
            const ExpenditureModel(
              id: '1',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
            const ExpenditureModel(
              id: '2',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
          ];
        });
      },
      expect: () => [
        const ExpenditureState.success(
          expenditures: [
            ExpenditureModel(
              id: '1',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
            ExpenditureModel(
              id: '2',
              category: 'transport',
              nameOfItem: 'transport',
              estimatedAmount: 500,
            ),
          ],
        ),
      ],
    );
    blocTest<ExpenditureCubit, ExpenditureState>(
      'Test That cubit state doesnt change when'
      ' expenditure when repository throws an api exception with refresh '
      'expenditure method call',
      build: () => expenditureCubit,
      act: (cubit) {
        cubit.onRefreshExpenditure();
      },
      setUp: () {
        when(() => mockExpenditureRepository.getAllExpenditure()).thenThrow(
          ApiException(message: 'Unable to fetch user Expenditure'),
        );
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => const [],
    );
  });
}
