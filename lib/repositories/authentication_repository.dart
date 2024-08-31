class AuthenticationRepository {
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
  }
}
