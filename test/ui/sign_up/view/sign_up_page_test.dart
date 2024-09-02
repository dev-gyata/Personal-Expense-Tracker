import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/models/email_model.dart';
import 'package:personal_expense_tracker/models/name_model.dart';
import 'package:personal_expense_tracker/models/password_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/ui/sign_up/cubit/sign_up_cubit.dart';
import 'package:personal_expense_tracker/ui/sign_up/view/sign_up_page.dart';

import '../../../helpers/pump_app.dart';

class MockSignupCubit extends MockCubit<SignUpState> implements SignUpCubit {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('SignupPage', () {
    late AuthenticationRepository authenticationRepository;
    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });
    testWidgets('renders SignupView', (tester) async {
      await tester.pumpApp(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: const SignUpPage(),
        ),
      );
      expect(find.byType(SignUpView), findsOneWidget);
    });
  });
  group('SignUpView', () {
    late SignUpCubit signUpCubit;

    setUp(() {
      signUpCubit = MockSignupCubit();
    });
    testWidgets(
        'Verify that screen  renders name invalid error when name entered is '
        'invalid', (tester) async {
      const state = SignUpState(
        name: NameModel.dirty('t'),
      );
      // stub for when state is call state
      when(() => signUpCubit.state).thenReturn(state);
      when(() => signUpCubit.onNameChanged('t')).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: signUpCubit,
          child: const SignUpView(),
        ),
      );

      const nameFieldKey = Key('signup_name_textfield');

      // Verify that our TextField is present
      expect(find.byKey(nameFieldKey), findsOneWidget);

      // Enter 'test' into the email field
      await tester.enterText(find.byKey(nameFieldKey), 't');

      // Trigger a frame
      await tester.pump();

      // Verify that the error text is displayed
      expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    });
    testWidgets(
        'Verify that screen  renders email invalid error when email entered is '
        'invalid', (tester) async {
      const state = SignUpState(
        email: EmailModel.dirty('test'),
      );
      // stub for when state is call state
      when(() => signUpCubit.state).thenReturn(state);
      when(() => signUpCubit.onEmailChanged('test')).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: signUpCubit,
          child: const SignUpView(),
        ),
      );

      const emailFieldKey = Key('signup_email_textfield');

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
      const state = SignUpState(
        password: PasswordModel.dirty('test'),
      );
      when(() => signUpCubit.state).thenReturn(state);
      when(() => signUpCubit.onPasswordChanged('test')).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: signUpCubit,
          child: const SignUpView(),
        ),
      );

      const passwordFieldKey = Key('signup_password_textfield');

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
      const state = SignUpState(
        name: NameModel.dirty('John'),
        email: EmailModel.dirty('example@example.com'),
        password: PasswordModel.dirty('Secure@123'),
        isValid: true,
        status: FormzSubmissionStatus.inProgress,
      );
      // initial state
      when(() => signUpCubit.state).thenReturn(state);

      await tester.pumpApp(
        BlocProvider.value(
          value: signUpCubit,
          child: const SignUpView(),
        ),
      );

      const nameFieldKey = Key('signup_name_textfield');
      const emailFieldKey = Key('signup_email_textfield');
      const passwordFieldKey = Key('signup_password_textfield');

      await tester.enterText(find.byKey(nameFieldKey), 'John');
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
