import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/enums/api_status.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/amount_model.dart';
import 'package:personal_expense_tracker/models/text_input_model.dart';
import 'package:personal_expense_tracker/repositories/'
    'expenditure_repository.dart';
import 'package:personal_expense_tracker/ui/create_expenditure/cubit/'
    'create_expenditure_cubit.dart';

class MockExpenditureRepository extends Mock implements ExpenditureRepository {}

void main() {
  group('CreateExpenditureCubit Test', () {
    late CreateExpenditureCubit createExpenditureCubit;
    late MockExpenditureRepository mockExpenditureRepository;
    setUp(() {
      mockExpenditureRepository = MockExpenditureRepository();
      createExpenditureCubit = CreateExpenditureCubit(
        expenditureRepository: mockExpenditureRepository,
      );
    });
    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onCategoryChanged emits correct state',
      build: () => createExpenditureCubit,
      act: (cubit) {
        cubit.onCategoryChanged('category');
      },
      expect: () => [
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
        ),
      ],
    );
    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onNameOfItemChanged emits correct state',
      build: () => createExpenditureCubit,
      act: (cubit) {
        cubit.onNameOfItemChanged('nameOfItem');
      },
      expect: () => [
        const CreateExpenditureState.initial().copyWith(
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
        ),
      ],
    );
    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onAmountChanged emits correct state',
      build: () => createExpenditureCubit,
      act: (cubit) {
        cubit.onEstimatedAmountChanged('20');
      },
      expect: () => [
        const CreateExpenditureState.initial().copyWith(
          estimatedAmount: const AmountModel.dirty('20'),
        ),
      ],
    );

    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onSubmit emits no state when form is invalid',
      build: () => createExpenditureCubit,
      act: (cubit) {
        cubit.onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => const [],
    );

    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onSubmit emits loading and success state when form is valid '
      'and repository returns success',
      build: () => createExpenditureCubit,
      setUp: () {
        when(
          () => mockExpenditureRepository.createExpenditure(
            nameOfItem: 'nameOfItem',
            estimatedAmount: 20,
            category: 'category',
          ),
        ).thenAnswer((_) => Future.value());
      },
      act: (cubit) {
        cubit
          ..onCategoryChanged('category')
          ..onNameOfItemChanged('nameOfItem')
          ..onEstimatedAmountChanged('20')
          ..onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => [
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.loading,
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.success,
        ),
      ],
    );
    blocTest<CreateExpenditureCubit, CreateExpenditureState>(
      'Test that onSubmit emits loading and failed state when form is valid '
      'but repository throws an exception',
      build: () => createExpenditureCubit,
      setUp: () {
        when(
          () => mockExpenditureRepository.createExpenditure(
            nameOfItem: 'nameOfItem',
            estimatedAmount: 20,
            category: 'category',
          ),
        ).thenThrow(ApiException(message: 'something went wrong'));
      },
      act: (cubit) {
        cubit
          ..onCategoryChanged('category')
          ..onNameOfItemChanged('nameOfItem')
          ..onEstimatedAmountChanged('20')
          ..onSubmit();
      },
      // ignore: inference_failure_on_collection_literal
      expect: () => [
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.loading,
        ),
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          nameOfItem: const TextInputModel.dirty('nameOfItem'),
          estimatedAmount: const AmountModel.dirty('20'),
          apiStatus: ApiStatus.failure,
          errorMessage: 'something went wrong',
        ),
      ],
    );
  });
}
