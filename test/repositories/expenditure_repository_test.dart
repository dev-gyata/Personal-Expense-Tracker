import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/dtos/expenditure_creation_request_dto.dart';
import 'package:personal_expense_tracker/dtos/expenditure_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/repositories/expenditure_repository.dart';
import 'package:personal_expense_tracker/services/expenditure_service.dart';

class MockExpenditureService extends Mock implements ExpenditureService {}

void main() {
  group('ExpenditureRepository Test', () {
    late MockExpenditureService mockExpenditureService;
    late ExpenditureRepository expenditureRepository;
    setUp(() {
      mockExpenditureService = MockExpenditureService();
      expenditureRepository = ExpenditureRepository(
        expenditureService: mockExpenditureService,
      );
    });

    test('Test that getAllExpenditure returns correct list of ExpenditureModel',
        () async {
      when(
        () => mockExpenditureService.getUserExpenditure(),
      ).thenAnswer(
        (_) => Future.value(
          [
            ExpenditureResponseDto.fromMap(const {
              'id': '1',
              'category': 'transport',
              'nameOfItem': 'transport',
              'estimatedAmount': '500.0',
            }),
            ExpenditureResponseDto.fromMap(const {
              'id': '2',
              'category': 'transport',
              'nameOfItem': 'transport',
              'estimatedAmount': '500.0',
            }),
          ],
        ),
      );
      final expenditures = await expenditureRepository.getAllExpenditure();
      expect(expenditures, <ExpenditureModel>[
        ExpenditureModel.fromExpenseResponseDto(
          dto: ExpenditureResponseDto.fromMap(const {
            'id': '1',
            'category': 'transport',
            'nameOfItem': 'transport',
            'estimatedAmount': '500.0',
          }),
        ),
        ExpenditureModel.fromExpenseResponseDto(
          dto: ExpenditureResponseDto.fromMap(const {
            'id': '2',
            'category': 'transport',
            'nameOfItem': 'transport',
            'estimatedAmount': '500.0',
          }),
        ),
      ]);
    });
    test('Test that deleteExpenditure returns correct deleted expenditure id',
        () async {
      when(
        () => mockExpenditureService.deleteUserExpenditure(
          expenditureId: '1',
        ),
      ).thenAnswer(
        (_) => Future.value(
          ExpenditureResponseDto.fromMap(const {
            'id': '1',
            'category': 'transport',
            'nameOfItem': 'transport',
            'estimatedAmount': '500.0',
          }),
        ),
      );
      final deletedExpenditure =
          await expenditureRepository.deleteExpenditure(id: '1');
      expect(
        deletedExpenditure,
        '1',
      );
    });
    test(
        'Test that deleteExpenditure throws ApiException when server '
        'response with 400 or 404', () async {
      when(
        () => mockExpenditureService.deleteUserExpenditure(
          expenditureId: 'invalid-id',
        ),
      ).thenThrow(
        ApiException(message: 'Invalid Expenditure id'),
      );
      expect(
        () => expenditureRepository.deleteExpenditure(id: 'invalid-id'),
        throwsA(isA<ApiException>()),
      );
    });

    test(
        'Test that createExpenditure returns normally when expenditure'
        ' was created successfully', () async {
      when(
        () => mockExpenditureService.createUserExpenditure(
          creationRequestDto: const ExpenditureCreationRequestDto(
            category: 'transport',
            nameOfItem: 'transport',
            estimatedAmount: 500,
          ),
        ),
      ).thenAnswer(
        (_) => Future.value(),
      );
      expect(
        () async => expenditureRepository.createExpenditure(
          nameOfItem: 'transport',
          estimatedAmount: 500,
          category: 'transport',
        ),
        returnsNormally,
      );
    });
  });
}
