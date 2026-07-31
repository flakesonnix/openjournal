import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:collection/collection.dart';

class IngestionWithCompanionAndCustomUnit {
  final Ingestion ingestion;
  final SubstanceCompanion? substanceCompanion;
  final CustomUnit? customUnit;

  IngestionWithCompanionAndCustomUnit({
    required this.ingestion,
    this.substanceCompanion,
    this.customUnit,
  });
}

class ExperienceListItem {
  final Experience experience;
  final List<IngestionWithCompanionAndCustomUnit> ingestions;
  final List<ShulginRating> ratings;

  ExperienceListItem({
    required this.experience,
    required this.ingestions,
    required this.ratings,
  });

  DateTime get sortInstant {
    if (ingestions.isEmpty) return experience.creationDate;
    // Get the earliest ingestion time
    return ingestions
        .map((i) => i.ingestion.time)
        .reduce((a, b) => a.isBefore(b) ? a : b);
  }

  ShulginRatingOption? get rating {
    final overall = ratings.firstWhereOrNull((r) => r.time == null)?.option;
    if (overall != null) return overall;

    if (ratings.isEmpty) return null;
    // Return the highest rating option (ordinal based)
    return ratings.map((r) => r.option).reduce((a, b) => a.index > b.index ? a : b);
  }
}
