// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interactions _$InteractionsFromJson(Map<String, dynamic> json) => Interactions(
  dangerous: (json['dangerous'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  unsafe: (json['unsafe'] as List<dynamic>).map((e) => e as String).toList(),
  uncertain: (json['uncertain'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$InteractionsToJson(Interactions instance) =>
    <String, dynamic>{
      'dangerous': instance.dangerous,
      'unsafe': instance.unsafe,
      'uncertain': instance.uncertain,
    };
