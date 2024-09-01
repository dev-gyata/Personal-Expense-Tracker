import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expense_tracker/enums/authentication_status.dart';
import 'package:personal_expense_tracker/models/user_model.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _statusSubscription = _authenticationRepository.status.listen((status) {
      switch (status) {
        case AuthenticationStatusAuthenticated(:final user):
          emit(AuthenticationState.authenticated(user));
        default:
          emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AuthenticationStatus>? _statusSubscription;

  Future<void> logOut() async {
    await _authenticationRepository.logOut();
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
}
