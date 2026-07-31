import 'package:json_annotation/json_annotation.dart';
import 'package:openjournal/models/substance/administration_route.dart';

part 'custom_unit.g.dart';

@JsonSerializable()
class CustomUnit {
  final int id;
  final String substanceName;
  final String name;
  final DateTime creationDate;
  final AdministrationRoute administrationRoute;
  final double? dose;
  final double? estimatedDoseStandardDeviation;
  final bool isEstimate;
  final bool isArchived;
  final String unit;
  final String? unitPlural;
  final String originalUnit;
  final String note;

  CustomUnit({
    this.id = 0,
    required this.substanceName,
    required this.name,
    required this.creationDate,
    required this.administrationRoute,
    this.dose,
    this.estimatedDoseStandardDeviation,
    required this.isEstimate,
    required this.isArchived,
    required this.unit,
    this.unitPlural,
    required this.originalUnit,
    required this.note,
  });

  factory CustomUnit.fromJson(Map<String, dynamic> json) => _$CustomUnitFromJson(json);
  Map<String, dynamic> toJson() => _$CustomUnitToJson(this);

  String get doseOfOneUnitDescription {
    if (dose == null) return "Unknown dose";

    if (isEstimate) {
      if (estimatedDoseStandardDeviation != null) {
        return "${dose!.toStringAsFixed(1)}±${estimatedDoseStandardDeviation!.toStringAsFixed(1)} $originalUnit";
      } else {
        return "~${dose!.toStringAsFixed(1)} $originalUnit";
      }
    } else {
      return "${dose!.toStringAsFixed(1)} $originalUnit";
    }
  }

  PluralizableUnit get pluralizableUnit {
    if (unitPlural != null) {
      return PluralizableUnit(singular: unit, plural: unitPlural!);
    }

    final lowerUnit = unit.toLowerCase();
    String calculatedPlural = unit;
    if (unit != "mg" && unit != "g" && lowerUnit != "ml" && !unit.endsWith('s')) {
      calculatedPlural = "${unit}s";
    }

    return PluralizableUnit(singular: unit, plural: calculatedPlural);
  }
}

class PluralizableUnit {
  final String singular;
  final String plural;

  PluralizableUnit({required this.singular, required this.plural});
}
