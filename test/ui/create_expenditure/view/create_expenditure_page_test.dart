import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/expenditure_repository.dart';
import 'package:personal_expense_tracker/ui/create_expenditure/cubit/create_expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/create_expenditure/view/create_expenditure_page.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';

import '../../../helpers/pump_app.dart';

class MockCreateExpenitureCubit extends MockCubit<CreateExpenditureState>
    implements CreateExpenditureCubit {}

class MockExpenditureRepository extends Mock implements ExpenditureRepository {}

void main() {
  group('Create Expenditure Page Test', () {
    late MockExpenditureRepository mockExpenditureRepository;
    setUp(() {
      mockExpenditureRepository = MockExpenditureRepository();
    });
    testWidgets('Verify that income page renders income View', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<ExpenditureRepository>.value(
          value: mockExpenditureRepository,
          child: Builder(
            builder: (context) {
              return const CreateExpenditurePage();
            },
          ),
        ),
      );
      expect(find.byType(CreateExpenditureView), findsOneWidget);
    });
  });

  group('Create Expenditure View', () {
    late MockCreateExpenitureCubit mockCreateExpenditureCubit;
    setUp(() {
      mockCreateExpenditureCubit = MockCreateExpenitureCubit();
    });
    testWidgets(
        'Verify that create expenditure page sumbit button is not '
        'loading when state is initial and the button is disabled',
        (tester) async {
      when(() => mockCreateExpenditureCubit.state)
          .thenReturn(const CreateExpenditureState.initial());
      await tester.pumpApp(
        BlocProvider<CreateExpenditureCubit>.value(
          value: mockCreateExpenditureCubit,
          child: Builder(
            builder: (context) {
              return const CreateExpenditureView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_expenditure_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);
      expect(
        tester.widget<AppButton>(find.byKey(submitButtonKey)).isLoading,
        isFalse,
      );

      await tester.tap(find.byKey(submitButtonKey));
      await tester.pumpAndSettle();
      verifyNever(() => mockCreateExpenditureCubit.onSubmit()).called(0);
    });

    testWidgets(
        'Verify that create expenditure page sumbit button is enabled when '
        'form is valid and onSubmit is called after tapping', (tester) async {
      when(() => mockCreateExpenditureCubit.state).thenReturn(
        const CreateExpenditureState.initial().copyWith(
          category: const TextInputModel.dirty('category'),
          estimatedAmount: const AmountModel.dirty('50'),
          nameOfItem: const TextInputModel.dirty('category'),
        ),
      );
      when(() => mockCreateExpenditureCubit.onSubmit()).thenAnswer(
        (_) async {},
      );
      await tester.pumpApp(
        BlocProvider<CreateExpenditureCubit>.value(
          value: mockCreateExpenditureCubit,
          child: Builder(
            builder: (context) {
              return const CreateExpenditureView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_expenditure_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);

      await tester.tap(find.byKey(submitButtonKey));
      await tester.pumpAndSettle();
      verify(() => mockCreateExpenditureCubit.onSubmit()).called(1);
    });

    testWidgets(
        'Verify that income page sumbit is changes to loading '
        'when state ApiStatus is loading', (tester) async {
      when(() => mockCreateExpenditureCubit.state)
          .thenReturn(const CreateExpenditureState.initial().loading());
      await tester.pumpApp(
        BlocProvider<CreateExpenditureCubit>.value(
          value: mockCreateExpenditureCubit,
          child: Builder(
            builder: (context) {
              return const CreateExpenditureView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_expenditure_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);
      expect(
        tester.widget<AppButton>(find.byKey(submitButtonKey)).isLoading,
        isTrue,
      );
    });
  });
}
