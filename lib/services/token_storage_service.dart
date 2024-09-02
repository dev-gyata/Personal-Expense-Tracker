import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  TokenStorageService({
    required FlutterSecureStorage storage,
  }) : _storage = storage;
  final FlutterSecureStorage _storage;

  Future<void> saveToken({
    required String accessToken,
  }) async {
    await _storage.write(key: 'accessToken', value: accessToken);
  }

  Future<String?> getToken() async {
    return _storage.read(key: 'accessToken');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'accessToken');
  }
}
