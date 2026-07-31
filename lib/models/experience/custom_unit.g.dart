// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUnit _$CustomUnitFromJson(Map<String, dynamic> json) => CustomUnit(
  id: (json['id'] as num?)?.toInt() ?? 0,
  substanceName: json['substanceName'] as String,
  name: json['name'] as String,
  creationDate: DateTime.parse(json['creationDate'] as String),
  administrationRoute: $enumDecode(
    _$AdministrationRouteEnumMap,
    json['administrationRoute'],
  ),
  dose: (json['dose'] as num?)?.toDouble(),
  estimatedDoseStandardDeviation:
      (json['estimatedDoseStandardDeviation'] as num?)?.toDouble(),
  isEstimate: json['isEstimate'] as bool,
  isArchived: json['isArchived'] as bool,
  unit: json['unit'] as String,
  unitPlural: json['unitPlural'] as String?,
  originalUnit: json['originalUnit'] as String,
  note: json['note'] as String,
);

Map<String, dynamic> _$CustomUnitToJson(CustomUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'substanceName': instance.substanceName,
      'name': instance.name,
      'creationDate': instance.creationDate.toIso8601String(),
      'administrationRoute':
          _$AdministrationRouteEnumMap[instance.administrationRoute]!,
      'dose': instance.dose,
      'estimatedDoseStandardDeviation': instance.estimatedDoseStandardDeviation,
      'isEstimate': instance.isEstimate,
      'isArchived': instance.isArchived,
      'unit': instance.unit,
      'unitPlural': instance.unitPlural,
      'originalUnit': instance.originalUnit,
      'note': instance.note,
    };

const _$AdministrationRouteEnumMap = {
  AdministrationRoute.oral: 'oral',
  AdministrationRoute.sublingual: 'sublingual',
  AdministrationRoute.buccal: 'buccal',
  AdministrationRoute.insufflated: 'insufflated',
  AdministrationRoute.rectal: 'rectal',
  AdministrationRoute.transdermal: 'transdermal',
  AdministrationRoute.subcutaneous: 'subcutaneous',
  AdministrationRoute.intramuscular: 'intramuscular',
  AdministrationRoute.intravenous: 'intravenous',
  AdministrationRoute.smoked: 'smoked',
  AdministrationRoute.inhaled: 'inhaled',
};
