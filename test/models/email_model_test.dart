import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/email_model.dart';

void main() {
  group('EmailModel Test', () {
    test(
        'Test that EmailModel returns correct validation error when '
        'email is invalid', () {
      const email = EmailModel.dirty('test');
      expect(email.isValid, false);
      expect(email.displayError, EmailValidationError.invalid);
    });
    test(
        'Test that EmailModel returns no validation error when '
        'email is valid', () {
      const email = EmailModel.dirty('test@example.com');
      expect(email.isValid, true);
      expect(email.displayError, isNull);
    });
  });
}
