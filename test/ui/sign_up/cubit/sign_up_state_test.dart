import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/ui/sign_up/cubit/sign_up_cubit.dart';

void main() {
  const email = EmailModel.dirty('example@example.com');
  const password = PasswordModel.dirty('Secure@123');
  const name = NameModel.dirty('Test');
  group('SignupState', () {
    test('supports value comparisons', () {
      expect(const SignUpState(), const SignUpState());
    });

    test('returns same object when no properties are passed', () {
      expect(const SignUpState().copyWith(), const SignUpState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const SignUpState().copyWith(status: FormzSubmissionStatus.initial),
        const SignUpState(),
      );
    });

    test('returns object with updated email when email is passed', () {
      expect(
        const SignUpState().copyWith(email: email),
        const SignUpState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const SignUpState().copyWith(password: password),
        const SignUpState(password: password),
      );
    });
    test('returns object with updated name when name is passed', () {
      expect(
        const SignUpState().copyWith(name: name),
        const SignUpState(name: name),
      );
    });
  });
}
