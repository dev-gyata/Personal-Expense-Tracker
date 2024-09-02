import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/dtos/expenditure_response_dto.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';

void main() {
  group('ExpenditureModel Test', () {
    test('Test that expenditure model is able to be created from valid  json',
        () {
      const json = '''
      {
        "id": "1",
        "category": "transport",
        "nameOfItem": "transport",
        "estimatedAmount": 500.0
      }
      ''';
      final expenditure = ExpenditureModel.fromExpenseResponseDto(
        dto: ExpenditureResponseDto.fromJson(
          json,
        ),
      );
      expect(expenditure.id, '1');
      expect(expenditure.category, 'transport');
      expect(expenditure.nameOfItem, 'transport');
      expect(expenditure.estimatedAmount, 500.0);
    });
    test('Test that expenditure model throws an expection when json is invalid',
        () {
      const json = '''
      {
        "id": "1",
        "category": "transport",
        "nameOfItem": "transport",
        "estimatedAmount": 500.0,dssf
      }
      ''';
      expect(
        () => ExpenditureModel.fromExpenseResponseDto(
          dto: ExpenditureResponseDto.fromJson(
            json,
          ),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('Test that calculatePercentage is able to the correct percentage', () {
      const json = '''
      {
        "id": "1",
        "category": "transport",
        "nameOfItem": "transport",
        "estimatedAmount": 500.0
      }
      ''';
      final expenditure = ExpenditureModel.fromExpenseResponseDto(
        dto: ExpenditureResponseDto.fromJson(
          json,
        ),
      );

      final allExpenditures = [
        ExpenditureModel.fromExpenseResponseDto(
          dto: ExpenditureResponseDto.fromJson(
            json,
          ),
        ),
        ExpenditureModel.fromExpenseResponseDto(
          dto: ExpenditureResponseDto.fromJson(
            json,
          ),
        ),
      ];
      final calculatedPercentage = expenditure.calculatePercentage(
        expenditures: allExpenditures,
      );
      expect(
        calculatedPercentage,
        50,
      );
    });
  });
}
