import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';

class OpenJournalRepository {
  final AppDatabase _db;

  OpenJournalRepository(this._db);

  Stream<List<Experience>> watchAllExperiences() {
    return (_db.select(_db.experiences)
          ..orderBy([
            (t) => OrderingTerm(expression: t.sortDate, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<int> insertExperience(ExperiencesCompanion experience) {
    return _db.into(_db.experiences).insert(experience);
  }

  Future<void> insertIngestion(IngestionsCompanion ingestion) {
    return _db.into(_db.ingestions).insert(ingestion);
  }

  // Add more methods as needed, mirroring ExperienceRepository.kt
}

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final openJournalRepositoryProvider = Provider<OpenJournalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return OpenJournalRepository(db);
});
