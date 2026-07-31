// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  text: json['text'] as String,
  creationDate: DateTime.parse(json['creationDate'] as String),
  sortDate: DateTime.parse(json['sortDate'] as String),
  isFavorite: json['isFavorite'] as bool,
  location: json['location'] == null
      ? null
      : Location.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'creationDate': instance.creationDate.toIso8601String(),
      'sortDate': instance.sortDate.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'location': instance.location,
    };
