import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';

void main() {
  group('ColorGenerator Test', () {
    test('Test that generateColorList returns exact number of colors requested',
        () {
      final colors = ColorGenerator.generateColorList(5);
      expect(colors.length, 5);
    });

    test('Test that generateColorList returns distinct colors', () {
      final colors = ColorGenerator.generateColorList(10);
      for (var i = 0; i < colors.length; i++) {
        for (var j = i + 1; j < colors.length; j++) {
          expect(colors[i] != colors[j], true);
        }
      }
    });
  });
}
