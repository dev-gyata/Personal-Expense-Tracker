import 'package:dio/dio.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/dtos/login_request_dto.dart';
import 'package:personal_expense_tracker/dtos/login_response_dto.dart';
import 'package:personal_expense_tracker/dtos/signup_request_dto.dart';
import 'package:personal_expense_tracker/dtos/user_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/exceptions/login_exception.dart';
import 'package:personal_expense_tracker/exceptions/signup_exception.dart';

class AuthenticationService {
  AuthenticationService({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<LoginResponseDto> logIn({
    required LoginRequestDto loginRequestDto,
  }) async {
    try {
      return LoginResponseDto.fromMap(const {});
      final response = await _dio.post(
        AppEndpoints.loginEndpoint,
        data: loginRequestDto.toJson(),
      );
      return LoginResponseDto.fromMap(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw LoginException(
          message: 'Invalid email or password',
        );
      }
      throw LoginException(
        message: 'Something went wrong while logging in',
      );
    } on Exception {
      throw LoginException(
        message: 'Something went wrong while logging in',
      );
    }
  }

  Future<void> signUp({
    required SignupRequestDto signupRequestDto,
  }) async {
    try {
      await _dio.post(
        AppEndpoints.signupEndpoint,
        data: signupRequestDto.toJson(),
      );
      return;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw SignupException(
          message: 'Invalid credentials',
        );
      }
      throw SignupException(
        message: 'Something went wrong while signing up',
      );
    } on Exception {
      throw SignupException(
        message: 'Something went wrong while signing up',
      );
    }
  }

  Future<UserResponseDto> getUser({
    required String userId,
  }) async {
    try {
      final response = await _dio.get(
        AppEndpoints.userProfileEndpoint.replaceAll('*', userId),
      );
      return UserResponseDto.fromMap(response.data as Map<String, dynamic>);
    } catch (_) {
      throw ApiException(
        message: 'Unable to fetch user details',
      );
    }
  }
}
