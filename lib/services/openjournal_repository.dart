import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:rxdart/rxdart.dart';

class OpenJournalRepository {
  final AppDatabase _db;

  OpenJournalRepository(this._db);

  Stream<List<ExperienceListItem>> watchExperienceList() {
    // In Drift, we can watch multiple tables and combine them.
    // For a complex join with lists (like Experience -> List<Ingestion>),
    // it's often easier to watch all three tables and combine in Dart.

    final experiencesStream = (_db.select(_db.experiences)
          ..orderBy([
            (t) => OrderingTerm(expression: t.sortDate, mode: OrderingMode.desc)
          ]))
        .watch();

    final ingestionsStream = _db.select(_db.ingestions).join([
      leftOuterJoin(_db.substanceCompanions,
          _db.substanceCompanions.substanceName.equalsExp(_db.ingestions.substanceName)),
      leftOuterJoin(_db.customUnits,
          _db.customUnits.id.equalsExp(_db.ingestions.customUnitId)),
    ]).watch();

    final ratingsStream = _db.select(_db.shulginRatings).watch();

    return Rx.combineLatest3(
      experiencesStream,
      ingestionsStream,
      ratingsStream,
      (List<Experience> exps, List<TypedResult> ingRows, List<ShulginRating> rats) {
        return exps.map((exp) {
          final expIngestions = ingRows
              .where((row) => row.readTable(_db.ingestions).experienceId == exp.id)
              .map((row) => IngestionWithCompanionAndCustomUnit(
                    ingestion: row.readTable(_db.ingestions),
                    substanceCompanion: row.readTableOrNull(_db.substanceCompanions),
                    customUnit: row.readTableOrNull(_db.customUnits),
                  ))
              .toList();

          final expRatings = rats.where((r) => r.experienceId == exp.id).toList();

          return ExperienceListItem(
            experience: exp,
            ingestions: expIngestions,
            ratings: expRatings,
          );
        }).toList();
      },
    );
  }

  Future<int> insertExperience(ExperiencesCompanion experience) {
    return _db.into(_db.experiences).insert(experience);
  }

  Future<void> insertIngestion(IngestionsCompanion ingestion) {
    return _db.into(_db.ingestions).insert(ingestion);
  }
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final openJournalRepositoryProvider = Provider<OpenJournalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return OpenJournalRepository(db);
});
