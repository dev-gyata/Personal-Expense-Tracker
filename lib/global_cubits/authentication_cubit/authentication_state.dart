part of 'authentication_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.user = const UserModel.empty(),
    this.status = AuthStatus.unknown,
    this.rememberMe = false,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated({
    required UserModel user,
    required bool rememberMe,
  }) : this._(
          user: user,
          status: AuthStatus.authenticated,
          rememberMe: rememberMe,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  final UserModel user;
  final AuthStatus status;
  final bool rememberMe;

  @override
  List<Object> get props => [user, status, rememberMe];
}
