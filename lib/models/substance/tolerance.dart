import 'package:json_annotation/json_annotation.dart';

part 'tolerance.g.dart';

@JsonSerializable()
class Tolerance {
  final String? full;
  final String? half;
  final String? zero;

  Tolerance({
    this.full,
    this.half,
    this.zero,
  });

  factory Tolerance.fromJson(Map<String, dynamic> json) => _$ToleranceFromJson(json);
  Map<String, dynamic> toJson() => _$ToleranceToJson(this);
}
