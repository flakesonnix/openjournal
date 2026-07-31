import 'package:json_annotation/json_annotation.dart';
import 'duration_units.dart';

part 'duration_range.g.dart';

@JsonSerializable()
class DurationRange {
  final double? min;
  final double? max;
  final DurationUnits? units;

  DurationRange({
    this.min,
    this.max,
    this.units,
  });

  factory DurationRange.fromJson(Map<String, dynamic> json) => _$DurationRangeFromJson(json);
  Map<String, dynamic> toJson() => _$DurationRangeToJson(this);

  String get text {
    final minStr = min?.toString().replaceFirst(RegExp(r'\.0$'), '') ?? '';
    final maxStr = max?.toString().replaceFirst(RegExp(r'\.0$'), '') ?? '';
    return '$minStr-$maxStr${units?.shortText ?? ''}';
  }

  double? get minInSec => (units != null && min != null) ? min! * units!.inSecondsMultiplier : null;
  double? get maxInSec => (units != null && max != null) ? max! * units!.inSecondsMultiplier : null;

  double? interpolateAtValueInSeconds(double value) {
    if (min == null || max == null || units == null) return null;
    final diff = max! - min!;
    final withUnit = min! + diff * value;
    return withUnit * units!.inSecondsMultiplier;
  }
}
