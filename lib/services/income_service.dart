import 'package:dio/dio.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/dtos/dtos.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';

class IncomeService {
  const IncomeService({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<IncomeResponseDto>> getUserIncome() async {
    try {
      final response = await _dio.get(
        AppEndpoints.incomeEndpoint,
      );
      // ignore: avoid_dynamic_calls
      return (response.data['data'] as List)
          .map((e) => IncomeResponseDto.fromMap(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (_) {
      throw ApiException(
        message: 'Unable to fetch user income',
      );
    }
  }

  Future<IncomeResponseDto> getUserIncomeById({
    required String incomeId,
  }) async {
    try {
      final response = await _dio.get(
        AppEndpoints.incomeByIdEndpoint.replaceAll('*', incomeId),
      );
      return IncomeResponseDto.fromMap(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ApiException(
          message: 'Invalid income id',
        );
      }
      if (e.response?.statusCode == 404) {
        throw ApiException(
          message: 'Income not found',
        );
      }
      throw ApiException(
        message: 'Unable to fetch user income',
      );
    }
  }

  Future<void> createUserIncome({
    required IncomeCreationRequestDto incomeRequestDto,
  }) async {
    try {
      // ignore: inference_failure_on_function_invocation
      await _dio.post(
        AppEndpoints.incomeEndpoint,
        data: incomeRequestDto.toJson(),
      );
    } on DioException {
      throw ApiException(
        message: 'Unable to create user income',
      );
    }
  }

  Future<IncomeResponseDto> deleteUserIncome({
    required String incomeId,
  }) async {
    try {
      // ignore: inference_failure_on_function_invocation
      final deletedIncomeResponse = await _dio.delete(
        AppEndpoints.incomeByIdEndpoint.replaceAll('*', incomeId),
      );
      return IncomeResponseDto.fromMap(
        deletedIncomeResponse.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ApiException(
          message: 'Invalid income id',
        );
      }
      if (e.response?.statusCode == 404) {
        throw ApiException(
          message: 'Income not found',
        );
      }
      throw ApiException(
        message: 'Unable to fetch user income',
      );
    }
  }
}
