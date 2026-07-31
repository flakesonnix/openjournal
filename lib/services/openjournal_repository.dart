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

  Future<List<String>> getRecentConsumerNames() async {
    final query = _db.selectOnly(_db.ingestions, distinct: true)
      ..addColumns([_db.ingestions.consumerName])
      ..limit(50);
    final results = await query.get();
    return results.map((r) => r.read(_db.ingestions.consumerName)).whereType<String>().toList();
  }

  Future<List<String>> getRecentNotesForSubstance(String substanceName) async {
    final query = _db.select(_db.ingestions)
      ..where((t) => t.substanceName.equals(substanceName))
      ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc)])
      ..limit(10);
    final results = await query.get();
    return results.map((r) => r.notes).whereType<String>().where((n) => n.isNotEmpty).toSet().toList();
  }

  Future<List<ExperienceListItem>> getExperiencesInRange(DateTime start, DateTime end) async {
    final query = _db.select(_db.experiences)
      ..where((t) => t.sortDate.isBetweenValues(start, end))
      ..orderBy([(t) => OrderingTerm(expression: t.sortDate, mode: OrderingMode.desc)]);

    final exps = await query.get();
    final result = <ExperienceListItem>[];

    for (var exp in exps) {
      final ingestions = await (_db.select(_db.ingestions)
            ..where((t) => t.experienceId.equals(exp.id)))
          .join([
        leftOuterJoin(_db.substanceCompanions,
            _db.substanceCompanions.substanceName.equalsExp(_db.ingestions.substanceName)),
        leftOuterJoin(_db.customUnits,
            _db.customUnits.id.equalsExp(_db.ingestions.customUnitId)),
      ]).get();

      final ratings = await (_db.select(_db.shulginRatings)
            ..where((t) => t.experienceId.equals(exp.id)))
          .get();

      result.add(ExperienceListItem(
        experience: exp,
        ingestions: ingestions.map((row) => IngestionWithCompanionAndCustomUnit(
          ingestion: row.readTable(_db.ingestions),
          substanceCompanion: row.readTableOrNull(_db.substanceCompanions),
          customUnit: row.readTableOrNull(_db.customUnits),
        )).toList(),
        ratings: ratings,
      ));
    }
    return result;
  }

  Future<SubstanceCompanion?> getSubstanceCompanion(String substanceName) {
    return (_db.select(_db.substanceCompanions)
          ..where((t) => t.substanceName.equals(substanceName)))
        .getSingleOrNull();
  }

  Future<int> saveIngestionFlow({
    required IngestionsCompanion ingestion,
    ExperiencesCompanion? newExperience,
    required SubstanceCompanionsCompanion companion,
  }) async {
    return await _db.transaction(() async {
      await _db.into(_db.substanceCompanions).insertOnConflictUpdate(companion);

      int experienceId = ingestion.experienceId.value;
      if (newExperience != null) {
        experienceId = await _db.into(_db.experiences).insert(newExperience);
      }

      await _db.into(_db.ingestions).insert(ingestion.copyWith(experienceId: Value(experienceId)));
      return experienceId;
    });
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
