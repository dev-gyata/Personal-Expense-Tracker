import 'package:dio/dio.dart';
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
        '/user/income',
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
        '/user/income/$incomeId',
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
      await _dio.post(
        '/user/income',
        data: incomeRequestDto.toJson(),
      );
    } on DioException catch (e) {
      throw ApiException(
        message: 'Unable to create user income',
      );
    }
  }

  Future<IncomeResponseDto> deleteUserIncome({
    required String incomeId,
  }) async {
    try {
      final deletedIncomeResponse = await _dio.delete(
        '/user/income/$incomeId',
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
