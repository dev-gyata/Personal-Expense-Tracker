import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/amount_model.dart';
import 'package:personal_expense_tracker/models/text_input_model.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/ui/create_income/cubit/create_income_cubit.dart';

class MockIncomeRepository extends Mock implements IncomeRepository {}

void main() {
  group('CreateIncomeCubit Test', () {
    late CreateIncomeCubit createIncomeCubit;
    late MockIncomeRepository mockIncomeRepository;
    setUp(() {
      mockIncomeRepository = MockIncomeRepository();
      createIncomeCubit = CreateIncomeCubit(
        incomeRepository: mockIncomeRepository,
      );
    });
    blocTest<CreateIncomeCubit, CreateIncomeState>(
      'Test that onNameOfRevenueChanged emits correct state '
      'with nameOfRevenue changed',
      build: () => createIncomeCubit,
      act: (cubit) {
        cubit.onNameOfRevenueChanged('nameOfRevenue');
      },
      expect: () => [
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('nameOfRevenue'),
        ),
      ],
    );
    blocTest<CreateIncomeCubit, CreateIncomeState>(
      'Test that onAmountChanged emits correct state '
      'with amount changed',
      build: () => createIncomeCubit,
      act: (cubit) {
        cubit.onAmountChanged('20');
      },
      expect: () => [
        const CreateIncomeState.initial().copyWith(
          amount: const AmountModel.dirty('20'),
        ),
      ],
    );

    blocTest<CreateIncomeCubit, CreateIncomeState>(
      'Test that onSubmit emits no state when form is invalid',
      build: () => createIncomeCubit,
      act: (cubit) {
        cubit.onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => const [],
    );

    blocTest<CreateIncomeCubit, CreateIncomeState>(
      'Test that onSubmit emits loading and success state when form is valid '
      'and repository returns success',
      build: () => createIncomeCubit,
      setUp: () {
        when(
          () => mockIncomeRepository.createUserIncome(
            amount: 20,
            nameOfRevenue: 'salary',
          ),
        ).thenAnswer((_) => Future.value());
      },
      act: (cubit) {
        cubit
          ..onNameOfRevenueChanged('salary')
          ..onAmountChanged('20')
          ..onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => [
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.loading,
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.success,
        ),
      ],
    );
    blocTest<CreateIncomeCubit, CreateIncomeState>(
      'Test that onSubmit emits loading and success state when form is valid '
      'and repository returns success',
      build: () => createIncomeCubit,
      setUp: () {
        when(
          () => mockIncomeRepository.createUserIncome(
            amount: 20,
            nameOfRevenue: 'salary',
          ),
        ).thenThrow(ApiException(message: 'something went wrong'));
      },
      act: (cubit) {
        cubit
          ..onNameOfRevenueChanged('salary')
          ..onAmountChanged('20')
          ..onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => [
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.loading,
        ),
        const CreateIncomeState.initial().copyWith(
          nameOfRevenue: const TextInputModel.dirty('salary'),
          amount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.failure,
          errorMessage: 'something went wrong',
        ),
      ],
    );
  });
}
