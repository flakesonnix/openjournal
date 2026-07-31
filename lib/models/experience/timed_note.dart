import 'package:json_annotation/json_annotation.dart';
import 'adaptive_color.dart';

part 'timed_note.g.dart';

@JsonSerializable()
class TimedNote {
  final int id;
  final DateTime? creationDate;
  final DateTime time;
  final String note;
  final AdaptiveColor color;
  final int experienceId;
  final bool isPartOfTimeline;

  TimedNote({
    this.id = 0,
    this.creationDate,
    required this.time,
    required this.note,
    required this.color,
    required this.experienceId,
    required this.isPartOfTimeline,
  });

  factory TimedNote.fromJson(Map<String, dynamic> json) => _$TimedNoteFromJson(json);
  Map<String, dynamic> toJson() => _$TimedNoteToJson(this);
}
