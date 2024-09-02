import 'dart:async';

import 'package:personal_expense_tracker/dtos/login_request_dto.dart';
import 'package:personal_expense_tracker/dtos/signup_request_dto.dart';
import 'package:personal_expense_tracker/enums/authentication_status.dart';
import 'package:personal_expense_tracker/models/user_model.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    required AuthenticationService authenticationService,
    required TokenStorageService tokenStorageService,
  })  : _authenticationService = authenticationService,
        _tokenStorageService = tokenStorageService;

  final AuthenticationService _authenticationService;
  final TokenStorageService _tokenStorageService;

  final _authController = StreamController<AuthenticationStatus>();

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final loginResponse = await _authenticationService.logIn(
      loginRequestDto: LoginRequestDto(email: email, password: password),
    );
    // Save user token
    await _tokenStorageService.saveToken(
      accessToken: loginResponse.accessToken,
    );
    // Get user details here
    _authController.add(
      const AuthenticationStatusAuthenticated(
        user: UserModel(name: 'name', email: 'email', id: 'id'),
      ),
    );
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
    await _tokenStorageService.deleteToken();
    _authController.add(const AuthenticationStatusUnauthenticated());
  }

  void dispose() => _authController.close();
}
