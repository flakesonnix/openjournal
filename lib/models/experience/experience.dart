import 'package:json_annotation/json_annotation.dart';
import 'location.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  final int id;
  final String title;
  final String text;
  final DateTime creationDate;
  final DateTime sortDate;
  final bool isFavorite;
  final Location? location;

  Experience({
    required this.id,
    required this.title,
    required this.text,
    required this.creationDate,
    required this.sortDate,
    required this.isFavorite,
    this.location,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
