// enum AuthenticationStatus { unknown, authenticated, unauthenticated }
//
import 'package:personal_expense_tracker/models/user_model.dart';

sealed class AuthenticationStatus {
  const AuthenticationStatus();
}

class AuthenticationStatusAuthenticated extends AuthenticationStatus {
  const AuthenticationStatusAuthenticated({
    required this.user,
    required this.rememberMe,
  });

  final UserModel user;
  final bool rememberMe;
}

class AuthenticationStatusUnauthenticated extends AuthenticationStatus {
  const AuthenticationStatusUnauthenticated();
}

class AuthenticationStatusUnknown extends AuthenticationStatus {
  const AuthenticationStatusUnknown();
}
