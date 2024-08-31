import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/login/cubit/login_cubit.dart';
import 'package:personal_expense_tracker/login/view/login_page.dart';
import 'package:personal_expense_tracker/models/email_model.dart';
import 'package:personal_expense_tracker/models/password_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

import '../../helpers/pump_app.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('LoginPage', () {
    late AuthenticationRepository authenticationRepository;
    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpApp(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: const LoginPage(),
        ),
      );
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
  group('LoginView', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
    });
    testWidgets(
        'Verify that screen  renders email invalid error when email entered is '
        'invalid', (tester) async {
      const state = LoginState(
        email: EmailModel.dirty('test'),
      );
      // stub for when state is call state
      when(() => loginCubit.state).thenReturn(state);
      when(() => loginCubit.onEmailChanged('test')).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: loginCubit,
          child: const LoginView(),
        ),
      );

      const emailFieldKey = Key('login_email_textfield');

      // Verify that our TextField is present
      expect(find.byKey(emailFieldKey), findsOneWidget);

      // Enter 'test' into the email field
      await tester.enterText(find.byKey(emailFieldKey), 'test');

      // Trigger a frame
      await tester.pump();

      // Verify that the error text is displayed
      expect(find.text('Enter a valid email address'), findsOneWidget);
    });

    testWidgets(
        'Verify that screen renders password invalid error when password '
        'entered is invalid', (tester) async {
      const state = LoginState(
        password: PasswordModel.dirty('test'),
      );
      when(() => loginCubit.state).thenReturn(state);
      when(() => loginCubit.onPasswordChanged('test')).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: loginCubit,
          child: const LoginView(),
        ),
      );

      const passwordFieldKey = Key('login_password_textfield');

      // Verify that our TextField is present
      expect(find.byKey(passwordFieldKey), findsOneWidget);

      // Enter 'test' into the password field
      await tester.enterText(find.byKey(passwordFieldKey), 'test');

      // Trigger a frame
      await tester.pump();

      // Verify that the error text is displayed
      expect(
        find.text('Password must be at least 8 characters'),
        findsOneWidget,
      );
    });

    testWidgets(
        'Verify that screen renders progress indicator when form is valid',
        (tester) async {
      const state = LoginState(
        email: EmailModel.dirty('example@example.com'),
        password: PasswordModel.dirty('Secure@123'),
        isValid: true,
        status: FormzSubmissionStatus.inProgress,
      );
      // initial state
      when(() => loginCubit.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: loginCubit,
          child: const LoginView(),
        ),
      );

      const emailFieldKey = Key('login_email_textfield');
      const passwordFieldKey = Key('login_password_textfield');

      await tester.enterText(find.byKey(emailFieldKey), 'example@example.com');
      await tester.enterText(find.byKey(passwordFieldKey), 'Secure@123');

      // Trigger a frame
      await tester.pump();

      // Verify that the progress indicator is displayed
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
    });
  });
}
