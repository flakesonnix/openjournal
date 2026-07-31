import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:openjournal/models/experience/stomach_fullness.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';

part 'database_service.g.dart';

class Experiences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get textContent => text().named('text')();
  DateTimeColumn get creationDate => dateTime()();
  DateTimeColumn get sortDate => dateTime()();
  BoolColumn get isFavorite => boolean()();
  TextColumn get locationName => text().nullable().named('name')();
  RealColumn get longitude => real().nullable()();
  RealColumn get latitude => real().nullable()();
}

class Ingestions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get substanceName => text()();
  DateTimeColumn get time => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  DateTimeColumn get creationDate => dateTime().nullable()();
  TextColumn get administrationRoute => text()();
  RealColumn get dose => real().nullable()();
  BoolColumn get isDoseAnEstimate => boolean()();
  RealColumn get estimatedDoseStandardDeviation => real().nullable()();
  TextColumn get units => text().nullable()();
  IntColumn get experienceId => integer().references(Experiences, #id)();
  TextColumn get notes => text().nullable()();
  TextColumn get stomachFullness => textEnum<StomachFullness>().nullable()();
  TextColumn get consumerName => text().nullable()();
  IntColumn get customUnitId => integer().nullable()();
}

class SubstanceCompanions extends Table {
  TextColumn get substanceName => text()();
  TextColumn get color => textEnum<AdaptiveColor>()();

  @override
  Set<Column> get primaryKey => {substanceName};
}

class CustomSubstances extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get units => text()();
  TextColumn get description => text()();
}

class ShulginRatings extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get time => dateTime().nullable()();
  DateTimeColumn get creationDate => dateTime().nullable()();
  TextColumn get option => textEnum<ShulginRatingOption>()();
  IntColumn get experienceId => integer().references(Experiences, #id)();
}

class TimedNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get creationDate => dateTime()();
  DateTimeColumn get time => dateTime()();
  TextColumn get note => text()();
  TextColumn get color => textEnum<AdaptiveColor>()();
  IntColumn get experienceId => integer().references(Experiences, #id)();
  BoolColumn get isPartOfTimeline => boolean()();
}

class CustomUnits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get substanceName => text()();
  TextColumn get name => text()();
  DateTimeColumn get creationDate => dateTime()();
  TextColumn get administrationRoute => text()();
  RealColumn get dose => real().nullable()();
  RealColumn get estimatedDoseStandardDeviation => real().nullable()();
  BoolColumn get isEstimate => boolean()();
  BoolColumn get isArchived => boolean()();
  TextColumn get unit => text()();
  TextColumn get unitPlural => text().nullable()();
  TextColumn get originalUnit => text()();
  TextColumn get note => text()();
}

@DriftDatabase(tables: [
  Experiences,
  Ingestions,
  SubstanceCompanions,
  CustomSubstances,
  ShulginRatings,
  TimedNotes,
  CustomUnits
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Complex Queries to mirror ExperienceDao.kt

  Stream<List<Experience>> getSortedExperiences() {
    return (select(experiences)..orderBy([(t) => OrderingTerm(expression: t.creationDate, mode: OrderingMode.desc)])).watch();
  }

  // Example of a joined query/relation
  // Drift handles relations differently than Room. We often return custom classes or tuples.
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
