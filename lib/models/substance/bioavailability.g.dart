// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bioavailability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bioavailability _$BioavailabilityFromJson(Map<String, dynamic> json) =>
    Bioavailability(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BioavailabilityToJson(Bioavailability instance) =>
    <String, dynamic>{'min': instance.min, 'max': instance.max};
