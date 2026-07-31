// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingestion _$IngestionFromJson(Map<String, dynamic> json) => Ingestion(
  id: (json['id'] as num?)?.toInt() ?? 0,
  substanceName: json['substanceName'] as String,
  time: DateTime.parse(json['time'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  creationDate: json['creationDate'] == null
      ? null
      : DateTime.parse(json['creationDate'] as String),
  administrationRoute: $enumDecode(
    _$AdministrationRouteEnumMap,
    json['administrationRoute'],
  ),
  dose: (json['dose'] as num?)?.toDouble(),
  isDoseAnEstimate: json['isDoseAnEstimate'] as bool,
  estimatedDoseStandardDeviation:
      (json['estimatedDoseStandardDeviation'] as num?)?.toDouble(),
  units: json['units'] as String?,
  experienceId: (json['experienceId'] as num).toInt(),
  notes: json['notes'] as String?,
  stomachFullness: $enumDecodeNullable(
    _$StomachFullnessEnumMap,
    json['stomachFullness'],
  ),
  consumerName: json['consumerName'] as String?,
  customUnitId: (json['customUnitId'] as num?)?.toInt(),
);

Map<String, dynamic> _$IngestionToJson(Ingestion instance) => <String, dynamic>{
  'id': instance.id,
  'substanceName': instance.substanceName,
  'time': instance.time.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'creationDate': instance.creationDate?.toIso8601String(),
  'administrationRoute':
      _$AdministrationRouteEnumMap[instance.administrationRoute]!,
  'dose': instance.dose,
  'isDoseAnEstimate': instance.isDoseAnEstimate,
  'estimatedDoseStandardDeviation': instance.estimatedDoseStandardDeviation,
  'units': instance.units,
  'experienceId': instance.experienceId,
  'notes': instance.notes,
  'stomachFullness': _$StomachFullnessEnumMap[instance.stomachFullness],
  'consumerName': instance.consumerName,
  'customUnitId': instance.customUnitId,
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

const _$StomachFullnessEnumMap = {
  StomachFullness.empty: 'empty',
  StomachFullness.quarterFull: 'quarterFull',
  StomachFullness.halfFull: 'halfFull',
  StomachFullness.full: 'full',
  StomachFullness.veryFull: 'veryFull',
};
