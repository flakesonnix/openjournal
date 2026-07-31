import 'package:json_annotation/json_annotation.dart';
import 'duration_range.dart';

part 'roa_duration.g.dart';

@JsonSerializable()
class RoaDuration {
  final DurationRange? onset;
  final DurationRange? comeup;
  final DurationRange? peak;
  final DurationRange? offset;
  final DurationRange? total;
  final DurationRange? afterglow;

  RoaDuration({
    this.onset,
    this.comeup,
    this.peak,
    this.offset,
    this.total,
    this.afterglow,
  });

  factory RoaDuration.fromJson(Map<String, dynamic> json) => _$RoaDurationFromJson(json);
  Map<String, dynamic> toJson() => _$RoaDurationToJson(this);
}
