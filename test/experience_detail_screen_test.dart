import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/experience_detail_screen.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  testWidgets('renders experience details', (tester) async {
    final expId = await db.into(db.experiences).insert(ExperiencesCompanion.insert(
          title: 'Test Session',
          textContent: 'A lovely evening',
          creationDate: DateTime(2026, 7, 30, 20),
          sortDate: DateTime(2026, 7, 30, 20),
          isFavorite: false,
          locationName: const Value('Home'),
        ));

    await db.into(db.ingestions).insert(IngestionsCompanion.insert(
          substanceName: 'LSD',
          time: DateTime(2026, 7, 30, 20, 30),
          administrationRoute: 'oral',
          dose: const Value(150),
          units: const Value('ug'),
          isDoseAnEstimate: true,
          experienceId: expId,
          notes: const Value('Come up after 40 min'),
        ));

    await db.into(db.timedNotes).insert(TimedNotesCompanion.insert(
          creationDate: DateTime(2026, 7, 30, 20, 30),
          time: DateTime(2026, 7, 30, 21, 15),
          note: 'Peak',
          color: AdaptiveColor.blue,
          experienceId: expId,
          isPartOfTimeline: true,
        ));

    await db.into(db.shulginRatings).insert(ShulginRatingsCompanion.insert(
          option: ShulginRatingOption.twoPlus,
          experienceId: expId,
        ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          openJournalRepositoryProvider.overrideWithValue(OpenJournalRepository(db)),
        ],
        child: MaterialApp(
          home: ExperienceDetailScreen(experienceId: expId),
        ),
      ),
    );
    await _pumpUntil(tester, find.text('LSD'));

    expect(find.text('Test Session'), findsOneWidget);
    expect(find.text('LSD'), findsOneWidget);
    expect(find.text('150 ug (estimate) · Oral'), findsOneWidget);
    expect(find.text('Come up after 40 min'), findsOneWidget);
    expect(find.text('Peak'), findsOneWidget);
    expect(find.text('++'), findsOneWidget);
    expect(find.text('A lovely evening'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('toggles favorite from app bar', (tester) async {
    final expId = await db.into(db.experiences).insert(ExperiencesCompanion.insert(
          title: 'Test Session',
          textContent: '',
          creationDate: DateTime(2026, 7, 30, 20),
          sortDate: DateTime(2026, 7, 30, 20),
          isFavorite: false,
        ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          openJournalRepositoryProvider.overrideWithValue(OpenJournalRepository(db)),
        ],
        child: MaterialApp(
          home: ExperienceDetailScreen(experienceId: expId),
        ),
      ),
    );
    await _pumpUntil(tester, find.byIcon(Icons.star_outline));

    expect(find.byIcon(Icons.star_outline), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star_outline));
    await _pumpUntil(tester, find.byIcon(Icons.star));

    expect(find.byIcon(Icons.star), findsOneWidget);

    final exp = await (db.select(db.experiences)..where((t) => t.id.equals(expId))).getSingle();
    expect(exp.isFavorite, isTrue);
  });
}

Future<void> _pumpUntil(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  final end = DateTime.now().add(timeout);
  while (finder.evaluate().isEmpty) {
    if (DateTime.now().isAfter(end)) {
      fail('Timed out waiting for ${finder.description}');
    }
    await tester.pump(const Duration(milliseconds: 50));
  }
}
