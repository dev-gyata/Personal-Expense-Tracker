import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/dtos/income_creation_request_dto.dart';
import 'package:personal_expense_tracker/dtos/income_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/services/income_service.dart';

class MockIncomeService extends Mock implements IncomeService {}

void main() {
  group('IncomeRepository Test', () {
    late IncomeRepository incomeRepository;
    late MockIncomeService mockIncomeService;
    setUp(() {
      mockIncomeService = MockIncomeService();
      incomeRepository = IncomeRepository(
        incomeService: mockIncomeService,
      );
    });
    test(
        ' Test that getAllUserIncome returns correct list of IncomeModel when '
        'request was successful', () async {
      when(() => mockIncomeService.getUserIncome()).thenAnswer(
        (_) => Future.value([
          const IncomeResponseDto(
            id: '1',
            nameOfRevenue: 'Savings',
            amount: 500,
          ),
          const IncomeResponseDto(
            id: '2',
            nameOfRevenue: 'Salary',
            amount: 500,
          ),
        ]),
      );
      final income = await incomeRepository.getAllUserIncome();
      expect(income, <IncomeModel>[
        const IncomeModel(
          id: '1',
          nameOfRevenue: 'Savings',
          amount: 500,
        ),
        const IncomeModel(
          id: '2',
          nameOfRevenue: 'Salary',
          amount: 500,
        ),
      ]);
    });
    test(
        'Test that createUserIncome returns normally when income was created '
        'successfully', () async {
      when(
        () => mockIncomeService.createUserIncome(
          incomeRequestDto: const IncomeCreationRequestDto(
            nameOfRevenue: 'Salary',
            amount: 500,
          ),
        ),
      ).thenAnswer(
        (_) => Future.value(),
      );
      expect(
        () => incomeRepository.createUserIncome(
          amount: 500,
          nameOfRevenue: 'Salary',
        ),
        returnsNormally,
      );
    });

    test('Test that deleteUserIncome returns correct deleted income id',
        () async {
      when(
        () => mockIncomeService.deleteUserIncome(
          incomeId: '1',
        ),
      ).thenAnswer(
        (_) => Future.value(
          IncomeResponseDto.fromMap(const {
            'id': '1',
            'nameOfRevenue': 'Salary',
            'amount': 500,
          }),
        ),
      );
      final deletedIncome = await incomeRepository.deleteUserIncome(id: '1');
      expect(
        deletedIncome,
        '1',
      );
    });
    test(
        'Test that deleteUserIncome throws ApiException when server '
        'response with 400 or 404', () async {
      when(
        () => mockIncomeService.deleteUserIncome(
          incomeId: 'invalid-id',
        ),
      ).thenThrow(
        ApiException(message: 'Invalid income id'),
      );
      expect(
        () async => incomeRepository.deleteUserIncome(id: 'invalid-id'),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
