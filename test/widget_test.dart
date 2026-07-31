import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/main.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('App boots to journal tab', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),
        databaseProvider.overrideWithValue(db),
        openJournalRepositoryProvider.overrideWithValue(OpenJournalRepository(db)),
      ],
    );
    addTearDown(container.dispose);
    await container.read(substanceServiceProvider).init();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const OpenJournalApp(),
      ),
    );
    await _pumpUntil(tester, find.text('No experiences yet'));

    expect(find.text('OpenJournal'), findsOneWidget);
    expect(find.text('No experiences yet'), findsOneWidget);
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
