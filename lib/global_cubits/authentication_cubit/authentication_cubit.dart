import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:personal_expense_tracker/enums/authentication_status.dart';
import 'package:personal_expense_tracker/models/user_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  AuthenticationCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    hydrate();
    _statusSubscription = _authenticationRepository.status.listen((status) {
      switch (status) {
        case AuthenticationStatusAuthenticated(:final user, :final rememberMe):
          emit(
            AuthenticationState.authenticated(
              rememberMe: rememberMe,
              user: user,
            ),
          );
        default:
          emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus>? _statusSubscription;

  void logOut() {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    return super.close();
  }

  void onUserLoggedIn() {
    if (_statusSubscription != null) {
      _statusSubscription?.resume();
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    final rememberMe = json['rememberMe'];
    if (rememberMe is bool && rememberMe) {
      final user = UserModel.fromMap(json['user'] as Map<String, dynamic>);
      _authenticationRepository.hydratedUser(
        user: user,
        rememberMe: rememberMe,
      );
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state.user != const UserModel.empty()) {
      return {
        'rememberMe': state.rememberMe,
        'user': state.user.toMap(),
      };
    }
    return null;
  }
}
