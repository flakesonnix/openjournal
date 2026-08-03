import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/experience/experience_detail_item.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/experience/openjournal_export.dart';
import 'package:openjournal/models/experience/location.dart' as loc;
import 'package:openjournal/models/experience/substance_companion.dart' as model;
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:rxdart/rxdart.dart';

class OpenJournalRepository {
  final AppDatabase _db;

  OpenJournalRepository(this._db);

  Future<void> deleteAllData() async {
    await _db.transaction(() async {
      await _db.delete(_db.experiences).go();
      await _db.delete(_db.ingestions).go();
      await _db.delete(_db.substanceCompanions).go();
      await _db.delete(_db.customSubstances).go();
      await _db.delete(_db.shulginRatings).go();
      await _db.delete(_db.timedNotes).go();
      await _db.delete(_db.customUnits).go();
    });
  }

  Future<OpenJournalExport> exportAllData() async {
    final experiences = await watchExperienceList().first;
    final companionsRows = await _db.select(_db.substanceCompanions).get();
    final customSubstances = await _db.select(_db.customSubstances).get();
    final customUnits = await _db.select(_db.customUnits).get();
    final allTimedNotes = await _db.select(_db.timedNotes).get();

    final experiencesSerializable = experiences.map((e) {
      final expNotes = allTimedNotes.where((n) => n.experienceId == e.experience.id).map((n) {
        return TimedNoteSerializable(
          creationDate: n.creationDate,
          time: n.time,
          note: n.note,
          color: AdaptiveColor.values.firstWhere((c) => c.name == n.color, orElse: () => AdaptiveColor.blue),
          isPartOfTimeline: n.isPartOfTimeline,
        );
      }).toList();

      return ExperienceSerializable(
        title: e.experience.title,
        text: e.experience.textContent,
        creationDate: e.experience.creationDate,
        sortDate: e.experience.sortDate,
        isFavorite: e.experience.isFavorite,
        location: e.experience.locationName != null
            ? loc.Location(
                name: e.experience.locationName!,
                longitude: e.experience.longitude,
                latitude: e.experience.latitude)
            : null,
        ingestions: e.ingestions.map((i) {
          return IngestionSerializable(
            substanceName: i.ingestion.substanceName,
            time: i.ingestion.time,
            endTime: i.ingestion.endTime,
            creationDate: i.ingestion.creationDate,
            administrationRoute:
                AdministrationRoute.values.firstWhere((r) => r.name == i.ingestion.administrationRoute),
            dose: i.ingestion.dose,
            isDoseAnEstimate: i.ingestion.isDoseAnEstimate,
            estimatedDoseStandardDeviation: i.ingestion.estimatedDoseStandardDeviation,
            units: i.ingestion.units,
            notes: i.ingestion.notes,
            stomachFullness: i.ingestion.stomachFullness,
            consumerName: i.ingestion.consumerName,
            customUnitId: i.ingestion.customUnitId,
          );
        }).toList(),
        ratings: e.ratings.map((r) {
          return RatingSerializable(
            option: r.option,
            time: r.time,
            creationDate: r.creationDate,
          );
        }).toList(),
        timedNotes: expNotes,
      );
    }).toList();

    return OpenJournalExport(
      experiences: experiencesSerializable,
      substanceCompanions: companionsRows.map((r) => model.SubstanceCompanion(
        substanceName: r.substanceName,
        color: r.color,
      )).toList(),
      customSubstances: customSubstances
          .map((s) => CustomSubstanceSerializable(
              id: s.id, name: s.name, units: s.units, description: s.description))
          .toList(),
      customUnits: customUnits
          .map((u) => CustomUnitSerializable(
                id: u.id,
                substanceName: u.substanceName,
                name: u.name,
                creationDate: u.creationDate,
                administrationRoute: AdministrationRoute.values
                    .firstWhere((r) => r.name == u.administrationRoute),
                dose: u.dose,
                estimatedDoseStandardDeviation: u.estimatedDoseStandardDeviation,
                isEstimate: u.isEstimate,
                isArchived: u.isArchived,
                unit: u.unit,
                unitPlural: u.unitPlural,
                originalUnit: u.originalUnit,
                note: u.note,
              ))
          .toList(),
    );
  }

  Future<void> importData(OpenJournalExport data) async {
    await _db.transaction(() async {
      await deleteAllData();

      for (var expSer in data.experiences) {
        final experienceId = await _db.into(_db.experiences).insert(ExperiencesCompanion.insert(
          title: expSer.title,
          textContent: expSer.text,
          creationDate: expSer.creationDate,
          sortDate: expSer.sortDate,
          isFavorite: expSer.isFavorite,
          locationName: Value(expSer.location?.name),
          longitude: Value(expSer.location?.longitude),
          latitude: Value(expSer.location?.latitude),
        ));

        for (var ingSer in expSer.ingestions) {
          await _db.into(_db.ingestions).insert(IngestionsCompanion.insert(
            substanceName: ingSer.substanceName,
            time: ingSer.time,
            endTime: Value(ingSer.endTime),
            creationDate: Value(ingSer.creationDate),
            administrationRoute: ingSer.administrationRoute.name,
            dose: Value(ingSer.dose),
            isDoseAnEstimate: ingSer.isDoseAnEstimate,
            estimatedDoseStandardDeviation: Value(ingSer.estimatedDoseStandardDeviation),
            units: Value(ingSer.units),
            experienceId: experienceId,
            notes: Value(ingSer.notes),
            stomachFullness: Value(ingSer.stomachFullness),
            consumerName: Value(ingSer.consumerName),
            customUnitId: Value(ingSer.customUnitId),
          ));
        }

        for (var ratSer in expSer.ratings) {
          await _db.into(_db.shulginRatings).insert(ShulginRatingsCompanion.insert(
            option: ratSer.option,
            time: Value(ratSer.time),
            creationDate: Value(ratSer.creationDate),
            experienceId: experienceId,
          ));
        }
      }

      for (var comp in data.substanceCompanions) {
        await _db.into(_db.substanceCompanions).insert(SubstanceCompanionsCompanion.insert(
          substanceName: comp.substanceName,
          color: comp.color,
        ));
      }

      for (var sub in data.customSubstances) {
        await _db.into(_db.customSubstances).insert(CustomSubstancesCompanion.insert(
          name: sub.name,
          units: sub.units,
          description: sub.description,
        ));
      }

      for (var unit in data.customUnits) {
        await _db.into(_db.customUnits).insert(CustomUnitsCompanion.insert(
          substanceName: unit.substanceName,
          name: unit.name,
          creationDate: unit.creationDate,
          administrationRoute: unit.administrationRoute.name,
          dose: Value(unit.dose),
          estimatedDoseStandardDeviation: Value(unit.estimatedDoseStandardDeviation),
          isEstimate: unit.isEstimate,
          isArchived: unit.isArchived,
          unit: unit.unit,
          unitPlural: Value(unit.unitPlural),
          originalUnit: unit.originalUnit,
          note: unit.note,
        ));
      }
    });
  }

  Stream<List<ExperienceListItem>> watchExperienceList() {
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

  Stream<ExperienceDetailItem> watchExperienceDetail(int experienceId) {
    final experienceStream = (_db.select(_db.experiences)
          ..where((t) => t.id.equals(experienceId)))
        .watchSingle();

    final ingestionsStream = (_db.select(_db.ingestions)
          ..where((t) => t.experienceId.equals(experienceId))
          ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.asc)]))
        .join([
      leftOuterJoin(_db.substanceCompanions,
          _db.substanceCompanions.substanceName.equalsExp(_db.ingestions.substanceName)),
      leftOuterJoin(_db.customUnits,
          _db.customUnits.id.equalsExp(_db.ingestions.customUnitId)),
    ]).watch();

    final ratingsStream = (_db.select(_db.shulginRatings)
          ..where((t) => t.experienceId.equals(experienceId))
          ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.asc)]))
        .watch();

    final timedNotesStream = (_db.select(_db.timedNotes)
          ..where((t) => t.experienceId.equals(experienceId))
          ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.asc)]))
        .watch();

    return Rx.combineLatest4(
      experienceStream,
      ingestionsStream,
      ratingsStream,
      timedNotesStream,
      (Experience exp, List<TypedResult> ingRows, List<ShulginRating> rats, List<TimedNote> notes) {
        return ExperienceDetailItem(
          listItem: ExperienceListItem(
            experience: exp,
            ingestions: ingRows
                .map((row) => IngestionWithCompanionAndCustomUnit(
                      ingestion: row.readTable(_db.ingestions),
                      substanceCompanion: row.readTableOrNull(_db.substanceCompanions),
                      customUnit: row.readTableOrNull(_db.customUnits),
                    ))
                .toList(),
            ratings: rats,
          ),
          timedNotes: notes,
        );
      },
    );
  }

  Future<void> setExperienceFavorite(int experienceId, bool isFavorite) {
    return (_db.update(_db.experiences)..where((t) => t.id.equals(experienceId)))
        .write(ExperiencesCompanion(isFavorite: Value(isFavorite)));
  }

  Future<int> insertExperience(ExperiencesCompanion experience) {
    return _db.into(_db.experiences).insert(experience);
  }

  Future<int> insertCustomSubstance(CustomSubstancesCompanion customSubstance) {
    return _db.into(_db.customSubstances).insert(customSubstance);
  }

  Future<int> insertCustomUnit(CustomUnitsCompanion customUnit) {
    return _db.into(_db.customUnits).insert(customUnit);
  }

  Stream<List<CustomUnit>> watchCustomUnits(String substanceName) {
    return (_db.select(_db.customUnits)
          ..where((t) => t.substanceName.equals(substanceName))
          ..orderBy([(t) => OrderingTerm(expression: t.creationDate, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<bool> updateExperience(ExperiencesCompanion experience) {
    return _db.update(_db.experiences).replace(experience);
  }

  Future<int> deleteExperience(int id) {
    return (_db.delete(_db.experiences)..where((t) => t.id.equals(id))).go();
  }

  Future<void> insertIngestion(IngestionsCompanion ingestion) {
    return _db.into(_db.ingestions).insert(ingestion);
  }

  Future<bool> updateIngestion(IngestionsCompanion ingestion) {
    return _db.update(_db.ingestions).replace(ingestion);
  }

  Future<int> deleteIngestion(int id) {
    return (_db.delete(_db.ingestions)..where((t) => t.id.equals(id))).go();
  }

  Future<int> insertTimedNote(TimedNotesCompanion note) {
    return _db.into(_db.timedNotes).insert(note);
  }

  Future<bool> updateTimedNote(TimedNotesCompanion note) {
    return _db.update(_db.timedNotes).replace(note);
  }

  Future<int> deleteTimedNote(int id) {
    return (_db.delete(_db.timedNotes)..where((t) => t.id.equals(id))).go();
  }

  Future<Map<DateTime, List<AdaptiveColor>>> getExperienceColorsByDay(DateTime start, DateTime end) async {
    final experiences = await getExperiencesInRange(start, end);
    final result = <DateTime, List<AdaptiveColor>>{};

    for (var exp in experiences) {
      final date = DateTime(exp.sortInstant.year, exp.sortInstant.month, exp.sortInstant.day);
      final colors = exp.ingestions
          .map((i) => i.substanceCompanion?.color)
          .whereType<AdaptiveColor>()
          .toList();

      if (result.containsKey(date)) {
        result[date]!.addAll(colors);
      } else {
        result[date] = colors;
      }
    }
    return result;
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
