import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class NameModel extends FormzInput<String, NameValidationError> {
  const NameModel.pure() : super.pure('');
  const NameModel.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.trim().length < 2) return NameValidationError.invalid;
    return null;
  }
}
