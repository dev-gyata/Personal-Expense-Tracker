import 'package:formz/formz.dart';

enum TextInputValidationError { invalid }

class TextInputModel extends FormzInput<String, TextInputValidationError> {
  const TextInputModel.pure() : super.pure('');
  const TextInputModel.dirty([super.value = '']) : super.dirty();

  @override
  TextInputValidationError? validator(String value) {
    if (value.trim().length < 2) {
      return TextInputValidationError.invalid;
    }
    return null;
  }
}
