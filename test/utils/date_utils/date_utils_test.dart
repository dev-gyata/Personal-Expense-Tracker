import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/utils/date_utils/date_utils.dart';

void main() {
  group('CurrentTimeUtils ...', () {
    test(
        'test that CurrentTimeUtils.getCurrentTime returns correct time '
        'for morning', () {
      final date = DateTime(
        2023,
        1,
        1,
        5,
      );
      final currentTime = CurrentTimeUtils.getCurrentTime(date: date);
      expect(currentTime, CurrentTime.morning);
    });

    test(
        'test that CurrentTimeUtils.getCurrentTime returns correct time '
        'for afternoon', () {
      final date = DateTime(
        2023,
        1,
        1,
        12,
      );
      final currentTime = CurrentTimeUtils.getCurrentTime(date: date);
      expect(currentTime, CurrentTime.afternoon);
    });
    test(
        'test that CurrentTimeUtils.getCurrentTime returns correct time '
        'for evening', () {
      final date = DateTime(
        2023,
        1,
        1,
        18,
      );
      final currentTime = CurrentTimeUtils.getCurrentTime(date: date);
      expect(currentTime, CurrentTime.evening);
    });
  });
}
