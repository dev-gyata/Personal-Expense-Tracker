import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('TokenStorageService Test', () {
    late TokenStorageService tokenStorageService;
    late MockFlutterSecureStorage mockFlutterSecureStorage;

    setUp(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
      tokenStorageService =
          TokenStorageService(storage: mockFlutterSecureStorage);
    });

    test('Test that saveToken returns normally', () {
      when(
        () => mockFlutterSecureStorage.write(
          key: 'accessToken',
          value: 'validAccessToken',
        ),
      ).thenAnswer(Future.value);
      expect(
        () => tokenStorageService.saveToken(accessToken: 'validAccessToken'),
        returnsNormally,
      );
    });
    test('Test that getToken returns  a valid token when token exist',
        () async {
      when(
        () => mockFlutterSecureStorage.read(
          key: 'accessToken',
        ),
      ).thenAnswer((_) => Future.value('validAccessToken'));
      final token = await tokenStorageService.getToken();
      expect(
        token,
        'validAccessToken',
      );
    });

    test('Test that getToken returns null when token does not exist', () async {
      when(
        () => mockFlutterSecureStorage.read(
          key: 'accessToken',
        ),
      ).thenAnswer((_) => Future.value());
      final token = await tokenStorageService.getToken();
      expect(
        token,
        null,
      );
    });

    test('Test that deleteToken returns normally', () async {
      when(
        () => mockFlutterSecureStorage.delete(
          key: 'accessToken',
        ),
      ).thenAnswer((_) => Future.value());
      expect(
        () => tokenStorageService.deleteToken(),
        returnsNormally,
      );
    });
  });
}
