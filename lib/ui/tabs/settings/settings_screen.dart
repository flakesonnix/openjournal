import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/tabs/settings/settings_state.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final security = ref.watch(securityServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        data: (state) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (state.isProcessing)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: LinearProgressIndicator(),
              ),

            CardWithTitle(
              title: "UI",
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Hide dosage dots'),
                    value: state.areDosageDotsHidden,
                    onChanged: notifier.updateDosageDotsHidden,
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Hide timeline'),
                    value: state.isTimelineHidden,
                    onChanged: notifier.updateTimelineHidden,
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Independent substance heights'),
                    value: state.areSubstanceHeightsIndependent,
                    onChanged: notifier.updateHeightsIndependent,
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Theme Mode'),
                    trailing: DropdownButton<AppThemeMode>(
                      value: state.themeMode,
                      items: AppThemeMode.values.map((mode) => DropdownMenuItem(
                        value: mode,
                        child: Text(mode.name.toUpperCase()),
                      )).toList(),
                      onChanged: (mode) => notifier.updateThemeMode(mode!),
                    ),
                  ),
                ],
              ),
            ),

            CardWithTitle(
              title: "App data",
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.upload),
                    title: const Text('Export File'),
                    onTap: notifier.exportData,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Import file'),
                    onTap: () => _confirmImport(context, notifier),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_forever, color: Colors.red),
                    title: const Text('Delete everything', style: TextStyle(color: Colors.red)),
                    onTap: () => _confirmDelete(context, notifier),
                  ),
                ],
              ),
            ),

            CardWithTitle(
              title: "Security",
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('App Lock'),
                    subtitle: Text(security.isAppLockEnabled
                        ? 'Enabled (${security.lockType.name})'
                        : 'Disabled'),
                    value: security.isAppLockEnabled,
                    onChanged: (value) {
                      if (!value) {
                        ref.read(securityServiceProvider).setLock(type: LockType.none);
                      } else {
                        // In real app, we'd navigate to a setup flow
                        // For now just toggle PIN for demo
                      }
                    },
                  ),
                ],
              ),
            ),

            CardWithTitle(
              title: "Feedback & App",
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.question_answer_outlined),
                    title: const Text('FAQ'),
                    onTap: () => launchUrl(Uri.parse('https://github.com/OpenPsychonaut/openjournal/wiki/FAQ')),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.code),
                    title: const Text('Source Code'),
                    onTap: () => launchUrl(Uri.parse('https://github.com/OpenPsychonaut/openjournal')),
                  ),
                  const Divider(),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final version = snapshot.data?.version ?? "Unknown";
                      return ListTile(
                        title: Text('Version $version'),
                        enabled: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _confirmImport(BuildContext context, SettingsNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import file?'),
        content: const Text('Import a file that was exported before. Note that this will delete the data that you already have in the app.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(context);
            notifier.importData();
          }, child: const Text('Import')),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, SettingsNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete everything?'),
        content: const Text('This will delete all your experiences, ingestions and custom substances.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.pop(context);
            notifier.deleteAllData();
          }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
