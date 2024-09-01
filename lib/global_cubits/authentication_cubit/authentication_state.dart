part of 'authentication_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.user = const UserModel.empty(),
    this.status = AuthStatus.unknown,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserModel user)
      : this._(user: user, status: AuthStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  final UserModel user;
  final AuthStatus status;

  @override
  List<Object> get props => [user, status];
}
