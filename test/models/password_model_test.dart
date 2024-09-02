import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/password_model.dart';

void main() {
  group('PasswordModel Test', () {
    test(
        'Test that PasswordModel returns correct validation error when '
        'password is invalid', () {
      const password = PasswordModel.dirty('test');
      expect(password.isValid, false);
      expect(password.displayError, PasswordValidationError.invalid);
    });
    test(
        'Test that PasswordModel returns correct validation error when '
        'password is invalid', () {
      const password = PasswordModel.dirty('Secure@123');
      expect(password.isValid, isTrue);
      expect(password.displayError, isNull);
    });
  });
}
