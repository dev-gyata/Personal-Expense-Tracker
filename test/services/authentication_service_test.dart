import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:personal_expense_tracker/dtos/login_request_dto.dart';
import 'package:personal_expense_tracker/dtos/login_response_dto.dart';
import 'package:personal_expense_tracker/dtos/signup_request_dto.dart';
import 'package:personal_expense_tracker/dtos/user_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/exceptions/login_exception.dart';
import 'package:personal_expense_tracker/exceptions/signup_exception.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';

void main() {
  group('AuthenticationService Test', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late AuthenticationService authenticationService;

    setUp(() {
      dio = Dio(
        BaseOptions(),
      );
      dioAdapter = DioAdapter(dio: dio, printLogs: true);
      authenticationService = AuthenticationService(dio: dio);
    });

    group('Login Test', () {
      test('test that valid login credentials returns a login response',
          () async {
        const email = 'test@example.com';
        const password = 'Secure@123';

        dioAdapter.onPost(
          '/auth/login',
          data: LoginRequestDto.fromMap(const {
            'email': 'test@example.com',
            'password': 'Secure@123',
          }).toJson(),
          (server) {
            return server.reply(
              200,
              {
                'message': 'success',
                'accessToken': 'accessToken',
                'expiresIn': 'expiresIn',
              },
            );
          },
        );

        final loginResponse = await authenticationService.logIn(
          loginRequestDto:
              const LoginRequestDto(email: email, password: password),
        );

        expect(
          loginResponse,
          LoginResponseDto.fromMap(
            const {
              'message': 'success',
              'accessToken': 'accessToken',
              'expiresIn': 'expiresIn',
            },
          ),
        );
      });

      test('test that invalid login credentials throws a login exception',
          () async {
        const email = 'bad@credentials.com';
        const password = '12345678';

        dioAdapter.onPost(
          '/auth/login',
          data: LoginRequestDto.fromMap(const {
            'email': 'bad@credentials.com',
            'password': '12345678',
          }).toJson(),
          (server) {
            return server.reply(
              400,
              {
                'message': 'Invalid email or password',
              },
            );
          },
        );

        expect(
          () => authenticationService.logIn(
            loginRequestDto:
                const LoginRequestDto(email: email, password: password),
          ),
          throwsA(isA<LoginException>()),
        );
      });
    });

    group('Signup Test', () {
      test('test that valid signup credentials returns a nothing', () async {
        const email = 'good@credentials.com';
        const password = '12345678';
        const name = 'Test';

        dioAdapter.onPost(
          '/auth/signup',
          data: SignupRequestDto.fromMap(const {
            'email': 'good@credentials.com',
            'password': '12345678',
            'name': 'Test',
          }).toJson(),
          (server) {
            return server.reply(
              201,
              {
                'message': 'new user added',
              },
            );
          },
        );
        expect(
          () => authenticationService.signUp(
            signupRequestDto: const SignupRequestDto(
              name: name,
              email: email,
              password: password,
            ),
          ),
          returnsNormally,
        );
      });

      test('test that invalid signup credentials throws a signup exception',
          () async {
        const email = 'bad@credentials.com';
        const password = '12345678';
        const name = 'Test';

        dioAdapter.onPost(
          '/auth/signup',
          data: SignupRequestDto.fromMap(const {
            'email': 'bad@credentials.com',
            'password': '12345678',
            'name': 'Test',
          }).toJson(),
          (server) {
            return server.reply(
              400,
              {
                'message': 'Invalid credentials',
              },
            );
          },
        );
        expect(
          () => authenticationService.signUp(
            signupRequestDto: const SignupRequestDto(
              name: name,
              email: email,
              password: password,
            ),
          ),
          throwsA(isA<SignupException>()),
        );
      });
    });
    group('Get User Test', () {
      test('test that getting user returns a valid user response', () async {
        const userId = '1';

        dioAdapter.onGet(
          '/auth/user/1/profile',
          (server) {
            return server.reply(200, {
              'id': '1',
              'email': 'john@email.com',
              'name': 'john doe',
            });
          },
        );
        final getUserReponse = await authenticationService.getUser(
          userId: userId,
        );
        expect(
          getUserReponse,
          UserResponseDto.fromMap(const {
            'id': '1',
            'email': 'john@email.com',
            'name': 'john doe',
          }),
        );
      });

      test('Test that getting user that do not exist throws an api exception',
          () async {
        const userId = 'wrong-id';

        dioAdapter.onGet(
          '/auth/user/wrong-id/profile',
          (server) {
            return server.reply(400, {
              'message': 'User not found',
            });
          },
        );
        expect(
          () async => authenticationService.getUser(userId: userId),
          throwsA(isA<ApiException>()),
        );
      });
    });
  });
}
