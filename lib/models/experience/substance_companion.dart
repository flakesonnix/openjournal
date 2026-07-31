import 'package:json_annotation/json_annotation.dart';
import 'adaptive_color.dart';

part 'substance_companion.g.dart';

@JsonSerializable()
class SubstanceCompanion {
  final String substanceName;
  final AdaptiveColor color;

  SubstanceCompanion({
    required this.substanceName,
    required this.color,
  });

  factory SubstanceCompanion.fromJson(Map<String, dynamic> json) => _$SubstanceCompanionFromJson(json);
  Map<String, dynamic> toJson() => _$SubstanceCompanionToJson(this);
}
