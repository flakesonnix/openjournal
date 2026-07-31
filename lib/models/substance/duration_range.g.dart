// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DurationRange _$DurationRangeFromJson(Map<String, dynamic> json) =>
    DurationRange(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
      units: $enumDecodeNullable(_$DurationUnitsEnumMap, json['units']),
    );

Map<String, dynamic> _$DurationRangeToJson(DurationRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'units': _$DurationUnitsEnumMap[instance.units],
    };

const _$DurationUnitsEnumMap = {
  DurationUnits.seconds: 'seconds',
  DurationUnits.minutes: 'minutes',
  DurationUnits.hours: 'hours',
  DurationUnits.days: 'days',
};
