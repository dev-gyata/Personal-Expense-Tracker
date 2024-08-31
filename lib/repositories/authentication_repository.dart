import 'dart:async';

import 'package:personal_expense_tracker/dtos/login_request_dto.dart';
import 'package:personal_expense_tracker/dtos/signup_request_dto.dart';
import 'package:personal_expense_tracker/enums/authentication_status.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  final AuthenticationService _authenticationService;

  final _authController = StreamController<AuthenticationStatus>();

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final loginResponse = await _authenticationService.logIn(
      loginRequestDto: LoginRequestDto(email: email, password: password),
    );
    // Save user token
    // Get user details here
    _authController.add(AuthenticationStatus.authenticated);
    // return
  }

  Future<void> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    await _authenticationService.signUp(
      signupRequestDto: SignupRequestDto(
        email: email,
        name: name,
        password: password,
      ),
    );
  }

  Stream<AuthenticationStatus> get status async* {
    yield* _authController.stream;
  }

  Future<void> logOut() async {
    // TODODelete credentials
    _authController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _authController.close();
}
