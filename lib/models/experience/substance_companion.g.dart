// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substance_companion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubstanceCompanion _$SubstanceCompanionFromJson(Map<String, dynamic> json) =>
    SubstanceCompanion(
      substanceName: json['substanceName'] as String,
      color: $enumDecode(_$AdaptiveColorEnumMap, json['color']),
    );

Map<String, dynamic> _$SubstanceCompanionToJson(SubstanceCompanion instance) =>
    <String, dynamic>{
      'substanceName': instance.substanceName,
      'color': _$AdaptiveColorEnumMap[instance.color]!,
    };

const _$AdaptiveColorEnumMap = {
  AdaptiveColor.blue: 'blue',
  AdaptiveColor.pink: 'pink',
  AdaptiveColor.indigo: 'indigo',
  AdaptiveColor.purple: 'purple',
  AdaptiveColor.cyan: 'cyan',
  AdaptiveColor.teal: 'teal',
  AdaptiveColor.green: 'green',
  AdaptiveColor.mint: 'mint',
  AdaptiveColor.yellow: 'yellow',
  AdaptiveColor.orange: 'orange',
  AdaptiveColor.red: 'red',
  AdaptiveColor.brown: 'brown',
  AdaptiveColor.grey: 'grey',
};
