import 'package:json_annotation/json_annotation.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'stomach_fullness.dart';

part 'ingestion.g.dart';

@JsonSerializable()
class Ingestion {
  final int id;
  final String substanceName;
  final DateTime time;
  final DateTime? endTime;
  final DateTime? creationDate;
  final AdministrationRoute administrationRoute;
  final double? dose;
  final bool isDoseAnEstimate;
  final double? estimatedDoseStandardDeviation;
  final String? units;
  final int experienceId;
  final String? notes;
  final StomachFullness? stomachFullness;
  final String? consumerName;
  final int? customUnitId;

  Ingestion({
    this.id = 0,
    required this.substanceName,
    required this.time,
    this.endTime,
    this.creationDate,
    required this.administrationRoute,
    this.dose,
    required this.isDoseAnEstimate,
    this.estimatedDoseStandardDeviation,
    this.units,
    required this.experienceId,
    this.notes,
    this.stomachFullness,
    this.consumerName,
    this.customUnitId,
  });

  factory Ingestion.fromJson(Map<String, dynamic> json) => _$IngestionFromJson(json);
  Map<String, dynamic> toJson() => _$IngestionToJson(this);
}
