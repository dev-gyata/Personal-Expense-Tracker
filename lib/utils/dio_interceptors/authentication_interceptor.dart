import 'package:dio/dio.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';

class AuthenticationInterceptor extends Interceptor {
  AuthenticationInterceptor({
    required TokenStorageService tokenStorageService,
  }) : _tokenStorageService = tokenStorageService;

  final TokenStorageService _tokenStorageService;

  Future<String?> getAccessToken() async {
    return _tokenStorageService.getToken();
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    super.onRequest(options, handler);
  }
}
