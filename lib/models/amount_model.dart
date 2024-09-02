import 'package:formz/formz.dart';

enum AmountValidationError { invalid }

class AmountModel extends FormzInput<String, AmountValidationError> {
  const AmountModel.pure() : super.pure('');
  const AmountModel.dirty([super.value = '']) : super.dirty();

  static final RegExp _amountRegex = RegExp(
    r'^\d+(\.\d{1,2})?$',
  );

  @override
  AmountValidationError? validator(String value) {
    if (_amountRegex.hasMatch(value)) {
      if (int.tryParse(value) == 0) {
        return AmountValidationError.invalid;
      }
      return null;
    }
    return AmountValidationError.invalid;
  }
}
