import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/ui/main_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/security/app_lock_guard.dart';
import 'package:openjournal/ui/tabs/settings/settings_state.dart';

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

class OpenJournalApp extends ConsumerWidget {
  const OpenJournalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'OpenJournal',
      routerConfig: router,
      theme: OpenJournalTheme.lightTheme,
      darkTheme: OpenJournalTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => AppLockGuard(child: child!),
    );
  }
}
