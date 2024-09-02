import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';
import 'package:personal_expense_tracker/utils/dio_interceptors/authentication_interceptor.dart';

class MockTokenStorageService extends Mock implements TokenStorageService {}

void main() {
  group('AuthenticationInterceptor Test', () {
    late MockTokenStorageService mockTokenStorageService;
    late AuthenticationInterceptor authenticationInterceptor;
    setUp(() {
      mockTokenStorageService = MockTokenStorageService();
      authenticationInterceptor = AuthenticationInterceptor(
        tokenStorageService: mockTokenStorageService,
      );
    });

    test(
      'Test that getAccessToken returns correct token if token exists '
      'in storage',
      () async {
        when(() => mockTokenStorageService.getToken()).thenAnswer(
          (_) => Future.value('validAccessToken'),
        );

        final token = await authenticationInterceptor.getAccessToken();
        expect(token, 'validAccessToken');
      },
    );
    test(
      'Test that getAccessToken returns null if token does not exists '
      'in storage',
      () async {
        when(() => mockTokenStorageService.getToken()).thenAnswer(
          (_) => Future.value(),
        );

        final token = await authenticationInterceptor.getAccessToken();
        expect(token, null);
      },
    );

    test(
      'Test that when onRequest is called and token exists in storage, '
      'Authorization header is added to request',
      () async {
        when(() => mockTokenStorageService.getToken()).thenAnswer(
          (_) => Future.value('validAccessToken'),
        );
        final requestOptions = RequestOptions();
        await authenticationInterceptor.onRequest(
          requestOptions,
          RequestInterceptorHandler(),
        );
        expect(
          requestOptions.headers['Authorization'],
          'Bearer validAccessToken',
        );
      },
    );
    test(
      'Test that when onRequest is called and token does not exists in '
      'storage, Authorization header is not added to request',
      () async {
        when(() => mockTokenStorageService.getToken()).thenAnswer(
          (_) => Future.value(),
        );
        final requestOptions = RequestOptions();
        await authenticationInterceptor.onRequest(
          requestOptions,
          RequestInterceptorHandler(),
        );
        expect(
          requestOptions.headers['Authorization'],
          null,
        );
      },
    );
  });
}
