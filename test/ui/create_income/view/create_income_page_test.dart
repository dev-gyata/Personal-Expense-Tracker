import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/models/amount_model.dart';
import 'package:personal_expense_tracker/models/text_input_model.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/ui/create_income/cubit'
    '/create_income_cubit.dart';
import 'package:personal_expense_tracker/ui/create_income/'
    'view/create_income_page.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';

import '../../../helpers/pump_app.dart';

class MockCreateIncomeCubit extends MockCubit<CreateIncomeState>
    implements CreateIncomeCubit {}

class MockIncomeRepository extends Mock implements IncomeRepository {}

void main() {
  group('Create Income Page Test', () {
    late MockIncomeRepository mockIncomeRepository;
    setUp(() {
      mockIncomeRepository = MockIncomeRepository();
    });
    testWidgets('Verify that income page renders income View', (tester) async {
      await tester.pumpApp(
        RepositoryProvider<IncomeRepository>.value(
          value: mockIncomeRepository,
          child: Builder(
            builder: (context) {
              return const CreateIncomePage();
            },
          ),
        ),
      );
      expect(find.byType(CreateIncomeView), findsOneWidget);
    });
  });

  group('Create Income View', () {
    late MockCreateIncomeCubit mockCreateIncomeCubit;
    setUp(() {
      mockCreateIncomeCubit = MockCreateIncomeCubit();
    });
    testWidgets(
        'Verify that income page sumbit button is not loading when state is'
        ' initial', (tester) async {
      when(() => mockCreateIncomeCubit.state)
          .thenReturn(const CreateIncomeState.initial());
      await tester.pumpApp(
        BlocProvider<CreateIncomeCubit>.value(
          value: mockCreateIncomeCubit,
          child: Builder(
            builder: (context) {
              return const CreateIncomeView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_income_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);
      expect(
        tester.widget<AppButton>(find.byKey(submitButtonKey)).isLoading,
        isFalse,
      );
    });

    testWidgets(
        'Verify that income page sumbit button is changes to loading '
        'when state ApiStatus is loading', (tester) async {
      when(() => mockCreateIncomeCubit.state)
          .thenReturn(const CreateIncomeState.initial().loading());
      when(() => mockCreateIncomeCubit.onSubmit()).thenAnswer(
        (_) async {},
      );
      await tester.pumpApp(
        BlocProvider<CreateIncomeCubit>.value(
          value: mockCreateIncomeCubit,
          child: Builder(
            builder: (context) {
              return const CreateIncomeView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_income_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);
      expect(
        tester.widget<AppButton>(find.byKey(submitButtonKey)).isLoading,
        isTrue,
      );

      await tester.tap(find.byKey(submitButtonKey));
      await tester.pump();
      // Verify that onSubmit is not called
      // when user taps button and button is loading
      verifyNever(mockCreateIncomeCubit.onSubmit);
    });

    testWidgets(
        'Verify that create expenditure page sumbit button is enabled when '
        'form is valid and onSubmit is called after tapping', (tester) async {
      when(() => mockCreateIncomeCubit.state).thenReturn(
        const CreateIncomeState.initial().copyWith(
          amount: const AmountModel.dirty('50'),
          nameOfRevenue: const TextInputModel.dirty('nameOfRevenue'),
        ),
      );
      when(() => mockCreateIncomeCubit.onSubmit()).thenAnswer(
        (_) async {},
      );
      await tester.pumpApp(
        BlocProvider<CreateIncomeCubit>.value(
          value: mockCreateIncomeCubit,
          child: Builder(
            builder: (context) {
              return const CreateIncomeView();
            },
          ),
        ),
      );
      const submitButtonKey = Key('create_income_submit_button');
      expect(find.byKey(submitButtonKey), findsOneWidget);

      await tester.tap(find.byKey(submitButtonKey));
      await tester.pumpAndSettle();
      verify(mockCreateIncomeCubit.onSubmit).called(1);
    });
  });
}
