import 'package:json_annotation/json_annotation.dart';
import 'package:openjournal/models/experience/experience.dart';
import 'package:openjournal/models/experience/substance_companion.dart';
import 'package:openjournal/models/experience/custom_unit.dart';
import 'package:openjournal/models/experience/shulgin_rating.dart';
import 'package:openjournal/models/experience/timed_note.dart';
import 'package:openjournal/models/experience/ingestion.dart';
import 'package:openjournal/models/experience/location.dart';
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/models/experience/stomach_fullness.dart';
import 'package:openjournal/models/substance/administration_route.dart';

part 'openjournal_export.g.dart';

@JsonSerializable()
class OpenJournalExport {
  final List<ExperienceSerializable> experiences;
  final List<SubstanceCompanion> substanceCompanions;
  final List<CustomSubstanceSerializable> customSubstances;
  final List<CustomUnitSerializable> customUnits;

  OpenJournalExport({
    this.experiences = const [],
    this.substanceCompanions = const [],
    this.customSubstances = const [],
    this.customUnits = const [],
  });

  factory OpenJournalExport.fromJson(Map<String, dynamic> json) => _$OpenJournalExportFromJson(json);
  Map<String, dynamic> toJson() => _$OpenJournalExportToJson(this);
}

@JsonSerializable()
class ExperienceSerializable {
  final String title;
  final String text;
  final DateTime creationDate;
  final DateTime sortDate;
  final bool isFavorite;
  final List<IngestionSerializable> ingestions;
  final Location? location;
  final List<RatingSerializable> ratings;
  final List<TimedNoteSerializable> timedNotes;

  ExperienceSerializable({
    required this.title,
    required this.text,
    required this.creationDate,
    required this.sortDate,
    this.isFavorite = false,
    this.ingestions = const [],
    this.location,
    this.ratings = const [],
    this.timedNotes = const [],
  });

  factory ExperienceSerializable.fromJson(Map<String, dynamic> json) => _$ExperienceSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceSerializableToJson(this);
}

@JsonSerializable()
class CustomSubstanceSerializable {
  final int id;
  final String name;
  final String units;
  final String description;

  CustomSubstanceSerializable({
    this.id = 0,
    required this.name,
    required this.units,
    required this.description,
  });

  factory CustomSubstanceSerializable.fromJson(Map<String, dynamic> json) => _$CustomSubstanceSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$CustomSubstanceSerializableToJson(this);
}

@JsonSerializable()
class CustomUnitSerializable {
  final int id;
  final String substanceName;
  final String name;
  final DateTime creationDate;
  final AdministrationRoute administrationRoute;
  final double? dose;
  final double? estimatedDoseStandardDeviation;
  final bool isEstimate;
  final bool isArchived;
  final String unit;
  final String? unitPlural;
  final String originalUnit;
  final String note;

  CustomUnitSerializable({
    this.id = 0,
    required this.substanceName,
    required this.name,
    required this.creationDate,
    required this.administrationRoute,
    this.dose,
    this.estimatedDoseStandardDeviation,
    required this.isEstimate,
    required this.isArchived,
    required this.unit,
    this.unitPlural,
    required this.originalUnit,
    required this.note,
  });

  factory CustomUnitSerializable.fromJson(Map<String, dynamic> json) => _$CustomUnitSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$CustomUnitSerializableToJson(this);
}

@JsonSerializable()
class RatingSerializable {
  final ShulginRatingOption option;
  final DateTime? time;
  final DateTime? creationDate;

  RatingSerializable({
    required this.option,
    this.time,
    this.creationDate,
  });

  factory RatingSerializable.fromJson(Map<String, dynamic> json) => _$RatingSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$RatingSerializableToJson(this);
}

@JsonSerializable()
class IngestionSerializable {
  final String substanceName;
  final DateTime time;
  final DateTime? endTime;
  final DateTime? creationDate;
  final AdministrationRoute administrationRoute;
  final double? dose;
  final bool isDoseAnEstimate;
  final double? estimatedDoseStandardDeviation;
  final String? units;
  final String? notes;
  final StomachFullness? stomachFullness;
  final String? consumerName;
  final int? customUnitId;

  IngestionSerializable({
    required this.substanceName,
    required this.time,
    this.endTime,
    this.creationDate,
    required this.administrationRoute,
    this.dose,
    required this.isDoseAnEstimate,
    this.estimatedDoseStandardDeviation,
    this.units,
    this.notes,
    this.stomachFullness,
    this.consumerName,
    this.customUnitId,
  });

  factory IngestionSerializable.fromJson(Map<String, dynamic> json) => _$IngestionSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$IngestionSerializableToJson(this);
}

@JsonSerializable()
class TimedNoteSerializable {
  final DateTime creationDate;
  final DateTime time;
  final String note;
  final AdaptiveColor color;
  final bool isPartOfTimeline;

  TimedNoteSerializable({
    required this.creationDate,
    required this.time,
    required this.note,
    required this.color,
    required this.isPartOfTimeline,
  });

  factory TimedNoteSerializable.fromJson(Map<String, dynamic> json) => _$TimedNoteSerializableFromJson(json);
  Map<String, dynamic> toJson() => _$TimedNoteSerializableToJson(this);
}
