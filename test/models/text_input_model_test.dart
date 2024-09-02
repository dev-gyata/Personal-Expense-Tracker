import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/text_input_model.dart';

void main() {
  group('TextInputModel Test', () {
    test(
        'Test that TextInputModel returns correct validation error when '
        'text value is invalid', () {
      const textModel = TextInputModel.dirty();
      expect(textModel.isValid, false);
      expect(textModel.displayError, TextInputValidationError.invalid);
    });
    test(
        'Test that TextInputModel returns no validation error when '
        'value is greater than 2 characters', () {
      const textModel = TextInputModel.dirty('valid');
      expect(textModel.isValid, true);
      expect(textModel.displayError, isNull);
    });
  });
}
