import 'package:json_annotation/json_annotation.dart';
import 'shulgin_rating_option.dart';

part 'shulgin_rating.g.dart';

@JsonSerializable()
class ShulginRating {
  final int id;
  final DateTime? time;
  final DateTime? creationDate;
  final ShulginRatingOption option;
  final int experienceId;

  ShulginRating({
    this.id = 0,
    this.time,
    this.creationDate,
    required this.option,
    required this.experienceId,
  });

  factory ShulginRating.fromJson(Map<String, dynamic> json) => _$ShulginRatingFromJson(json);
  Map<String, dynamic> toJson() => _$ShulginRatingToJson(this);
}
