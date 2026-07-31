import 'package:intl/intl.dart';
import 'dart:math';

extension DoubleExtension on double {
  String toReadableString() {
    if (this == 0) return "0";
    final numberOfSignificantDigits = this > 1 ? 3 : 2;
    final roundedNumber = _roundToSignificantDigits(this, numberOfSignificantDigits);
    return _formatToMaximumFractionDigits(roundedNumber, 6);
  }

  double _roundToSignificantDigits(double value, int digits) {
    if (value == 0) return 0;
    final d = (log(value.abs()) / ln10).ceil();
    final power = digits - d;
    final magnitude = pow(10, power);
    final shifted = (value * magnitude).round();
    return shifted / magnitude;
  }

  String _formatToMaximumFractionDigits(double value, int maxFractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = maxFractionDigits;
    // In Dart intl, grouping is controlled by the constructor usually (e.g. decimalPattern)
    // but decimalPattern doesn't allow setting min/max digits as easily as the standard constructor?
    // Actually the standard constructor defaults to no grouping if it's just 'NumberFormat()'?
    return formatter.format(value);
  }
}
