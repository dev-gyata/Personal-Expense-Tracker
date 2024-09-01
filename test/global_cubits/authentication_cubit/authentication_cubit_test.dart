import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/enums/authentication_status.dart';
import 'package:personal_expense_tracker/global_cubits/authentication_cubit/authentication_cubit.dart';
import 'package:personal_expense_tracker/models/user_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group('AuthenticationCubit Test', () {
    const user = UserModel(name: 'Felix', email: 'felix@example.com', id: '1');
    late AuthenticationRepository mockAuthenticationRepository;
    setUp(() {
      mockAuthenticationRepository = MockAuthenticationRepository();
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit the correct authenticated state when authentication '
      'repo  stream emits authentication status authenticated',
      build: () {
        return AuthenticationCubit(
          authenticationRepository: mockAuthenticationRepository,
        );
      },
      setUp: () {
        when(
          () => mockAuthenticationRepository.status,
        ).thenAnswer(
          (_) =>
              Stream.value(const AuthenticationStatusAuthenticated(user: user)),
        );
      },
      act: (cubit) {},
      expect: () => [
        const AuthenticationState.authenticated(user),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit the correct user unauthenticated state when authentication '
      'repo  stream emits authentication status unauthenticated',
      build: () {
        return AuthenticationCubit(
          authenticationRepository: mockAuthenticationRepository,
        );
      },
      setUp: () {
        when(
          () => mockAuthenticationRepository.status,
        ).thenAnswer(
          (_) => Stream.value(const AuthenticationStatusUnauthenticated()),
        );
      },
      act: (cubit) {},
      expect: () => [
        const AuthenticationState.unauthenticated(),
      ],
    );
  });
}
