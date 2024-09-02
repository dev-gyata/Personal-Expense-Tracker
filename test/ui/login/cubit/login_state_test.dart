import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/models/email_model.dart';
import 'package:personal_expense_tracker/models/password_model.dart';
import 'package:personal_expense_tracker/ui/login/cubit/login_cubit.dart';

void main() {
  const email = EmailModel.dirty('example@example.com');
  const password = PasswordModel.dirty('Secure@123');
  group('LoginState', () {
    test('supports value comparisons', () {
      expect(const LoginState(), const LoginState());
    });

    test('returns same object when no properties are passed', () {
      expect(const LoginState().copyWith(), const LoginState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const LoginState().copyWith(status: FormzSubmissionStatus.initial),
        const LoginState(),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const LoginState().copyWith(email: email),
        const LoginState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const LoginState().copyWith(password: password),
        const LoginState(password: password),
      );
    });
  });
}
