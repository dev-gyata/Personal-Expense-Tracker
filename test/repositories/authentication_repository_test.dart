import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/dtos/login_request_dto.dart';
import 'package:personal_expense_tracker/dtos/login_response_dto.dart';
import 'package:personal_expense_tracker/dtos/signup_request_dto.dart';
import 'package:personal_expense_tracker/exceptions/login_exception.dart';
import 'package:personal_expense_tracker/exceptions/signup_exception.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockTokenStorageService extends Mock implements TokenStorageService {}

void main() {
  group('Authentication Repository', () {
    late AuthenticationRepository authenticationRepository;
    late MockAuthenticationService mockAuthenticationService;
    late MockTokenStorageService mockTokenStorageService;

    setUp(() {
      mockAuthenticationService = MockAuthenticationService();
      mockTokenStorageService = MockTokenStorageService();
      authenticationRepository = AuthenticationRepository(
        authenticationService: mockAuthenticationService,
        tokenStorageService: mockTokenStorageService,
      );
    });

    tearDown(() {
      authenticationRepository.dispose();
    });

    group('Login', () {
      test('test that valid login credentials returns normally', () async {
        const email = 'test@example.com';
        const password = 'Secure@123';

        when(
          () => mockAuthenticationService.logIn(
            loginRequestDto: const LoginRequestDto(
              email: 'test@example.com',
              password: 'Secure@123',
            ),
          ),
        ).thenAnswer((_) async {
          return LoginResponseDto.fromMap(
            const {
              'message': 'success',
              'accessToken': 'accessToken',
              'expiresIn': 'expiresIn',
            },
          );
        });
        when(
          () => mockTokenStorageService.saveToken(
            accessToken: 'accessToken',
          ),
        ).thenAnswer((_) async {
          return;
        });

        expect(
          () => authenticationRepository.logIn(
            email: email,
            password: password,
          ),
          returnsNormally,
        );
      });
      test('test that invalid login credentials throw Login Exception',
          () async {
        const email = 'bad@example.com';
        const password = 'Secure@123';

        when(
          () => mockAuthenticationService.logIn(
            loginRequestDto: const LoginRequestDto(
              email: 'bad@example.com',
              password: 'Secure@123',
            ),
          ),
        ).thenAnswer((_) async {
          throw LoginException(message: 'Invalid email or password');
        });

        expect(
          () => authenticationRepository.logIn(
            email: email,
            password: password,
          ),
          throwsA(isA<LoginException>()),
        );
      });
    });
    group('Signup', () {
      test('test that valid login credentials returns normally', () async {
        const email = 'test@example.com';
        const password = 'Secure@123';
        const name = 'Test';

        when(
          () => mockAuthenticationService.signUp(
            signupRequestDto: const SignupRequestDto(
              email: 'test@example.com',
              password: 'Secure@123',
              name: 'Test',
            ),
          ),
        ).thenAnswer((_) async {
          return;
        });

        expect(
          () => authenticationRepository.signUp(
            email: email,
            password: password,
            name: name,
          ),
          returnsNormally,
        );
      });
      test('test that invalid login credentials throw Login Exception',
          () async {
        const email = 'bad@example.com';
        const password = 'Secure@123';
        const name = 'Bad';

        when(
          () => mockAuthenticationService.signUp(
            signupRequestDto: const SignupRequestDto(
              email: 'bad@example.com',
              password: 'Secure@123',
              name: 'Bad',
            ),
          ),
        ).thenAnswer((_) async {
          throw SignupException(message: 'Invalid credentials');
        });

        expect(
          () => authenticationRepository.signUp(
            email: email,
            password: password,
            name: name,
          ),
          throwsA(isA<SignupException>()),
        );
      });
    });
  });
}
