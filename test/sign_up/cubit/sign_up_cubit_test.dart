import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/exceptions/signup_exception.dart';
import 'package:personal_expense_tracker/login/cubit/login_cubit.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/sign_up/cubit/sign_up_cubit.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  group('SignUp Cubit', () {
    test('initial state is SignUpState', () {
      final signupCubit = SignUpCubit(
        authenticationRepository: authenticationRepository,
      );
      expect(signupCubit.state, const SignUpState());
    });

    group('signup Submitted', () {
      blocTest<SignUpCubit, SignUpState>(
        'cubit emits [submissionInProgress, submissionSuccess] '
        'when signup succeeds',
        build: () =>
            SignUpCubit(authenticationRepository: authenticationRepository),
        act: (cubit) {
          cubit
            ..onNameChanged('Test')
            ..onEmailChanged('example@example.com')
            ..onPasswordChanged('Secure@123')
            ..onSubmit();
        },
        setUp: () {
          when(
            () => authenticationRepository.signUp(
              name: 'Test',
              email: 'example@example.com',
              password: 'Secure@123',
            ),
          ).thenAnswer((_) => Future<void>.value());
        },
        expect: () => [
          const SignUpState(
            name: NameModel.dirty('Test'),
          ),
          const SignUpState(
            name: NameModel.dirty('Test'),
            email: EmailModel.dirty('example@example.com'),
          ),
          const SignUpState(
            name: NameModel.dirty('Test'),
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
          ),
          const SignUpState(
            name: NameModel.dirty('Test'),
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          const SignUpState(
            name: NameModel.dirty('Test'),
            email: EmailModel.dirty('example@example.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.success,
          ),
        ],
      );
      blocTest<SignUpCubit, SignUpState>(
        'cubit emits [submissionInProgress, submissionFailed] '
        'when signup fails',
        build: () =>
            SignUpCubit(authenticationRepository: authenticationRepository),
        act: (cubit) {
          cubit
            ..onNameChanged('Bad')
            ..onEmailChanged('bad@credentials.com')
            ..onPasswordChanged('Secure@123')
            ..onSubmit();
        },
        setUp: () {
          when(
            () => authenticationRepository.signUp(
              name: 'Bad',
              email: 'bad@credentials.com',
              password: 'Secure@123',
            ),
          ).thenAnswer(
            (_) => throw SignupException(message: 'Invalid credentials'),
          );
        },
        expect: () => [
          const SignUpState(
            name: NameModel.dirty('Bad'),
          ),
          const SignUpState(
            name: NameModel.dirty('Bad'),
            email: EmailModel.dirty('bad@credentials.com'),
          ),
          const SignUpState(
            name: NameModel.dirty('Bad'),
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
          ),
          const SignUpState(
            name: NameModel.dirty('Bad'),
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.inProgress,
          ),
          const SignUpState(
            name: NameModel.dirty('Bad'),
            email: EmailModel.dirty('bad@credentials.com'),
            password: PasswordModel.dirty('Secure@123'),
            isValid: true,
            status: FormzSubmissionStatus.failure,
          ),
        ],
      );
    });
  });
}
