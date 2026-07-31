import 'package:json_annotation/json_annotation.dart';

part 'bioavailability.g.dart';

@JsonSerializable()
class Bioavailability {
  final double? min;
  final double? max;

  Bioavailability({
    this.min,
    this.max,
  });

  factory Bioavailability.fromJson(Map<String, dynamic> json) => _$BioavailabilityFromJson(json);
  Map<String, dynamic> toJson() => _$BioavailabilityToJson(this);
}
