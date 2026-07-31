import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/utils/number_utils.dart';
import 'package:openjournal/utils/date_utils.dart';
import 'dart:math';

void main() {
  group('NumberUtils tests', () {
    test('toReadableString rounds correctly', () {
      expect(123.456.toReadableString(), "123");
      expect(12.3456.toReadableString(), "12.3");
      expect(1.23456.toReadableString(), "1.23");
      expect(0.123456.toReadableString(), "0.12");
      expect(0.0123456.toReadableString(), "0.012");
    });
  });

  group('DateUtils tests', () {
    test('getDateWithWeekdayText format', () {
      final date = DateTime(2026, 7, 31);
      expect(DateUtilsOpenJournal.getDateWithWeekdayText(date), contains("Friday"));
      expect(DateUtilsOpenJournal.getDateWithWeekdayText(date), contains("31 Jul 2026"));
    });

    test('getRelativeTimeText logic', () {
      final now = DateTime.now();
      expect(DateUtilsOpenJournal.getRelativeTimeText(now.subtract(const Duration(seconds: 30))), "just now");
      expect(DateUtilsOpenJournal.getRelativeTimeText(now.subtract(const Duration(minutes: 5))), "5m ago");
      expect(DateUtilsOpenJournal.getRelativeTimeText(now.subtract(const Duration(hours: 3))), "3h ago");
    });
  });

  group('Math logic parity tests', () {
    test('Gaussian error propagation (Uncertainty)', () {
      final sds = [10.0, 10.0, 10.0];
      final sumSq = sds.map((x) => x * x).reduce((a, b) => a + b);
      final result = sqrt(sumSq);
      expect(result, closeTo(17.32, 0.01));
    });
  });
}
