import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/dtos/dtos.dart';
import 'package:personal_expense_tracker/models/income_model.dart';

void main() {
  group('IncomeModel Test', () {
    test('Test that income model is able to be created from valid  json', () {
      const json = '''
      {
        "id": "1",
        "nameOfRevenue": "Salary",
        "amount": 500.0
      }
      ''';
      final income = IncomeModel.fromIncomeResponseDto(
        dto: IncomeResponseDto.fromJson(
          json,
        ),
      );
      expect(income.id, '1');
      expect(income.nameOfRevenue, 'Salary');
      expect(income.amount, 500.0);
    });
    test('Test that income model throws an expection when json is invalid', () {
      const json = '''
      {
        "id": "1",
        "nameOfRevenue": "wrong-salary",
        "amount": 500.0,dssf
      }
      ''';
      expect(
        () => IncomeModel.fromIncomeResponseDto(
          dto: IncomeResponseDto.fromJson(
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
        "nameOfRevenue": "Salary",
        "amount": 500.0
      }
      ''';
      final income = IncomeModel.fromIncomeResponseDto(
        dto: IncomeResponseDto.fromJson(
          json,
        ),
      );

      final allIncome = [
        IncomeModel.fromIncomeResponseDto(
          dto: IncomeResponseDto.fromJson(
            json,
          ),
        ),
        IncomeModel.fromIncomeResponseDto(
          dto: IncomeResponseDto.fromJson(
            json,
          ),
        ),
      ];
      final calculatedPercentage = income.calculatePercentage(
        allIncome: allIncome,
      );
      expect(
        calculatedPercentage,
        50,
      );
    });
  });
}
