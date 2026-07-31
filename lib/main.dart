import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/ui/main_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/security/app_lock_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );
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
      builder: (context, child) => AppLockGuard(child: child!),
    );
  }
}
