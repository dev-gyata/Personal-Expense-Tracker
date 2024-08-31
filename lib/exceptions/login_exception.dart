class LoginException implements Exception {
  LoginException({
    this.message = 'Unable to login',
  });
  final String message;
}
