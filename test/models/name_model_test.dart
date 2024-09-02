import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/models.dart';

void main() {
  group('NameModel Test', () {
    test(
        'Test that NameModel returns correct validation error when name '
        'is invalid', () {
      const name = NameModel.dirty('1');
      expect(name.isValid, false);
      expect(name.displayError, NameValidationError.invalid);
    });
    test('Test that NameModel returns no validation error when name is valid',
        () {
      const name = NameModel.dirty('Kofi');
      expect(name.isValid, true);
      expect(name.displayError, isNull);
    });
  });
}
