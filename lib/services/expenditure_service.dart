import 'package:dio/dio.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/dtos/dtos.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';

class ExpenditureService {
  const ExpenditureService({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<ExpenditureResponseDto>> getUserExpenditure() async {
    try {
      return <ExpenditureResponseDto>[
        ExpenditureResponseDto.fromMap(const {
          'id': '1',
          'category': 'transport',
          'nameOfItem': 'transport',
          'estimatedAmount': '500.0',
        }),
        ExpenditureResponseDto.fromMap(const {
          'id': '1',
          'category': 'bills',
          'nameOfItem': 'transport',
          'estimatedAmount': '200.0',
        }),
        ExpenditureResponseDto.fromMap(const {
          'id': '1',
          'category': 'rent',
          'nameOfItem': 'transport',
          'estimatedAmount': '100.0',
        }),
        ExpenditureResponseDto.fromMap(const {
          'id': '1',
          'category': 'party',
          'nameOfItem': 'transport',
          'estimatedAmount': '100.0',
        }),
        ExpenditureResponseDto.fromMap(const {
          'id': '1',
          'category': 'movies',
          'nameOfItem': 'transport',
          'estimatedAmount': '100.0',
        }),
      ];
      final response = await _dio.get(
        AppEndpoints.expenditureEndpoint,
      );
      // ignore: avoid_dynamic_calls
      return (response.data['data'] as List)
          .map((e) => ExpenditureResponseDto.fromMap(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (_) {
      throw ApiException(
        message: 'Unable to fetch user Expenditure',
      );
    }
  }

  Future<ExpenditureResponseDto> getUserExpenditureById({
    required String expenditureId,
  }) async {
    try {
      final response = await _dio.get(
        AppEndpoints.expenditureByIdEndpoint.replaceAll('*', expenditureId),
      );
      return ExpenditureResponseDto.fromMap(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ApiException(
          message: 'Invalid Expenditure id',
        );
      }
      if (e.response?.statusCode == 404) {
        throw ApiException(
          message: 'Expenditure not found',
        );
      }
      throw ApiException(
        message: 'Unable to fetch user expenditure',
      );
    }
  }

  Future<void> createUserExpenditure({
    required ExpenditureCreationRequestDto creationRequestDto,
  }) async {
    try {
      await _dio.post(
        AppEndpoints.expenditureEndpoint,
        data: creationRequestDto.toJson(),
      );
    } on DioException {
      throw ApiException(
        message: 'Unable to create user Expenditure',
      );
    }
  }

  Future<ExpenditureResponseDto> deleteUserExpenditure({
    required String expenditureId,
  }) async {
    try {
      final deletedExpenditureResponse = await _dio.delete(
        AppEndpoints.expenditureByIdEndpoint.replaceAll('*', expenditureId),
      );
      return ExpenditureResponseDto.fromMap(
        deletedExpenditureResponse.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ApiException(
          message: 'Invalid Expenditure id',
        );
      }
      if (e.response?.statusCode == 404) {
        throw ApiException(
          message: 'Expenditure not found',
        );
      }
      throw ApiException(
        message: 'Unable to fetch user expenditure',
      );
    }
  }
}
