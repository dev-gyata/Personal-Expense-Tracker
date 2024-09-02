import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/config/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AppTheme Test', () {
    setUp(() {
      HttpOverrides.global = null;
    });
    test('Test that lightTheme returns correct light brigthness', () {
      final theme = AppTheme.lightTheme;
      expect(theme.brightness, Brightness.light);
    });
    test('Test that darkTheme returns correct dark brigthness', () {
      final theme = AppTheme.darkTheme;
      expect(theme.brightness, Brightness.dark);
    });
  });
}
