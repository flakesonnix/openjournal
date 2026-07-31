import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/utils/number_utils.dart';
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

  group('Math logic parity tests', () {
    test('Gaussian error propagation (Uncertainty)', () {
      // Correct way to sum independent SDs: sqrt(sd1^2 + sd2^2 + ...)
      final sds = [10.0, 10.0, 10.0];
      final sumSq = sds.map((x) => x * x).reduce((a, b) => a + b);
      final result = sqrt(sumSq);

      expect(result, closeTo(17.32, 0.01));
    });
  });
}
