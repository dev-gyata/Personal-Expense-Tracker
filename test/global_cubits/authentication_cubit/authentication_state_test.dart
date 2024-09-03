import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/global_cubits/authentication_cubit/authentication_cubit.dart';
import 'package:personal_expense_tracker/models/user_model.dart';

class MockUser extends Mock implements UserModel {}

void main() {
  group('AuthenticationState', () {
    group('AuthenticationState.unknown', () {
      test('supports value comparisons', () {
        expect(
          const AuthenticationState.unknown(),
          const AuthenticationState.unknown(),
        );
      });
    });

    group('AuthenticationState.authenticated', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          AuthenticationState.authenticated(
            user: user,
            rememberMe: false,
          ),
          AuthenticationState.authenticated(
            user: user,
            rememberMe: false,
          ),
        );
      });
    });

    group('AuthenticationState.unauthenticated', () {
      test('supports value comparisons', () {
        expect(
          const AuthenticationState.unauthenticated(),
          const AuthenticationState.unauthenticated(),
        );
      });
    });
  });
}
