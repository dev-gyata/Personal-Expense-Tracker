class SignupException implements Exception {
  SignupException({
    this.message = 'Unable to login',
  });
  final String message;
}
