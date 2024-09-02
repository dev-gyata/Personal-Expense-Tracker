import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/amount_model.dart';

void main() {
  group('AmountModel Test', () {
    test(
        'Test that AmountModel returns correct validation error when '
        'amount value is invalid', () {
      const amountModel = AmountModel.dirty('-123');
      expect(amountModel.isValid, false);
      expect(amountModel.displayError, AmountValidationError.invalid);
    });
    test(
        'Test that AmountModel returns no validation error when '
        'amount is valid', () {
      const amountModel = AmountModel.dirty('20.99');
      expect(amountModel.isValid, true);
      expect(amountModel.displayError, isNull);
    });
  });
}
