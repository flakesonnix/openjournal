import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/ui/main_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(substanceServiceProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const OpenJournalApp(),
    ),
  );
}

class OpenJournalApp extends StatelessWidget {
  const OpenJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'OpenJournal',
      routerConfig: router,
      theme: OpenJournalTheme.lightTheme,
      darkTheme: OpenJournalTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
