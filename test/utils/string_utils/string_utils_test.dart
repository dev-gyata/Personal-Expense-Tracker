import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/utils/string_utils/string_utils.dart';

void main() {
  group('StringUtils Test', () {
    test('Test that StringUtils.capitalizeFirstCharacter returns correct value',
        () {
      expect(StringUtils.capitalizeFirstCharacter('test'), 'Test');
      expect(StringUtils.capitalizeFirstCharacter('Test'), 'Test');
      expect(StringUtils.capitalizeFirstCharacter(''), '');
      expect(StringUtils.capitalizeFirstCharacter('t'), 'T');
    });
  });
}
