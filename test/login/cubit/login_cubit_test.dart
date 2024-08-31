import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/login/cubit/login_cubit.dart';
import 'package:personal_expense_tracker/models/email_model.dart';
import 'package:personal_expense_tracker/models/password_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('Login Cubit', () {
    test('initial state is LoginState', () {
      final loginBloc = LoginCubit(
        authenticationRepository: authenticationRepository,
      );
      expect(loginBloc.state, const LoginState());
    });

    group('Login Submitted', () {
      blocTest<LoginCubit, LoginState>(
        'cubit emits [submissionInProgress, submissionSuccess] '
        'when login succeeds',
        build: () =>
            LoginCubit(authenticationRepository: authenticationRepository),
        act: (cubit) {
          cubit
            ..onEmailChanged('example@example.com')
            ..onPasswordChanged('Secure@123')
            ..onSubmit();
        },
        setUp: () {
          when(
            () => authenticationRepository.logIn(
              email: 'example@example.com',
              password: 'Secure@123',
            ),
          ).thenAnswer((_) => Future<String>.value('user'));
        },
        expect: () => [
          const LoginState(email: EmailModel.dirty('example@example.com')),
          const LoginState(
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
          ),
          const LoginState(
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          const LoginState(
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );
      blocTest<LoginCubit, LoginState>(
        'cubit emits [submissionInProgress, submissionFailed] '
        'when login fails',
        build: () =>
            LoginCubit(authenticationRepository: authenticationRepository),
        act: (cubit) {
          cubit
            ..onEmailChanged('bad@credentials.com')
            ..onPasswordChanged('Secure@123')
            ..onSubmit();
        },
        setUp: () {
          when(
            () => authenticationRepository.logIn(
              email: 'bad@credentials.com',
              password: 'Secure@123',
            ),
          ).thenAnswer((_) => Future<String>.value('invalid user'));
        },
        expect: () => [
          const LoginState(email: EmailModel.dirty('bad@credentials.com')),
          const LoginState(
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
          ),
          const LoginState(
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          const LoginState(
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );
    });
  });
}
