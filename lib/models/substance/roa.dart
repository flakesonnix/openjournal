import 'package:json_annotation/json_annotation.dart';
import 'administration_route.dart';
import 'roa_dose.dart';
import 'roa_duration.dart';
import 'bioavailability.dart';

part 'roa.g.dart';

@JsonSerializable()
class Roa {
  final AdministrationRoute route;
  @JsonKey(name: 'dose')
  final RoaDose? roaDose;
  @JsonKey(name: 'duration')
  final RoaDuration? roaDuration;
  final Bioavailability? bioavailability;

  Roa({
    required this.route,
    this.roaDose,
    this.roaDuration,
    this.bioavailability,
  });

  factory Roa.fromJson(Map<String, dynamic> json) => _$RoaFromJson(json);
  Map<String, dynamic> toJson() => _$RoaToJson(this);
}
