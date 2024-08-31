import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordModel extends FormzInput<String, PasswordValidationError> {
  const PasswordModel.pure() : super.pure('');
  const PasswordModel.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.trim().length < 8) return PasswordValidationError.invalid;
    return null;
  }
}
