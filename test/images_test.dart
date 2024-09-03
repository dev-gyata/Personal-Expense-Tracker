import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.appBarPattern).existsSync(), isTrue);
  });
}
