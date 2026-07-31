import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/file_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class SettingsState {
  final bool areDosageDotsHidden;
  final bool isTimelineHidden;
  final bool areSubstanceHeightsIndependent;
  final AppThemeMode themeMode;
  final bool isProcessing;
  final String? lastError;

  SettingsState({
    required this.areDosageDotsHidden,
    required this.isTimelineHidden,
    required this.areSubstanceHeightsIndependent,
    required this.themeMode,
    this.isProcessing = false,
    this.lastError,
  });

  SettingsState copyWith({
    bool? areDosageDotsHidden,
    bool? isTimelineHidden,
    bool? areSubstanceHeightsIndependent,
    AppThemeMode? themeMode,
    bool? isProcessing,
    String? lastError,
  }) {
    return SettingsState(
      areDosageDotsHidden: areDosageDotsHidden ?? this.areDosageDotsHidden,
      isTimelineHidden: isTimelineHidden ?? this.isTimelineHidden,
      areSubstanceHeightsIndependent: areSubstanceHeightsIndependent ?? this.areSubstanceHeightsIndependent,
      themeMode: themeMode ?? this.themeMode,
      isProcessing: isProcessing ?? this.isProcessing,
      lastError: lastError,
    );
  }
}

class SettingsNotifier extends AutoDisposeAsyncNotifier<SettingsState> {
  static const _keyDotsHidden = "settings_dots_hidden";
  static const _keyTimelineHidden = "settings_timeline_hidden";
  static const _keyHeightsIndependent = "settings_heights_independent";
  static const _keyThemeMode = "settings_theme_mode";

  @override
  FutureOr<SettingsState> build() async {
    final prefs = ref.watch(sharedPreferencesProvider);

    return SettingsState(
      areDosageDotsHidden: prefs.getBool(_keyDotsHidden) ?? false,
      isTimelineHidden: prefs.getBool(_keyTimelineHidden) ?? false,
      areSubstanceHeightsIndependent: prefs.getBool(_keyHeightsIndependent) ?? false,
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == prefs.getString(_keyThemeMode),
        orElse: () => AppThemeMode.system,
      ),
    );
  }

  Future<void> updateDosageDotsHidden(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_keyDotsHidden, value);
    state = AsyncValue.data(state.value!.copyWith(areDosageDotsHidden: value));
  }

  Future<void> updateTimelineHidden(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_keyTimelineHidden, value);
    state = AsyncValue.data(state.value!.copyWith(isTimelineHidden: value));
  }

  Future<void> updateHeightsIndependent(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_keyHeightsIndependent, value);
    state = AsyncValue.data(state.value!.copyWith(areSubstanceHeightsIndependent: value));
  }

  Future<void> updateThemeMode(AppThemeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_keyThemeMode, mode.name);
    state = AsyncValue.data(state.value!.copyWith(themeMode: mode));
  }

  Future<void> exportData() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final fileService = ref.read(fileServiceProvider);

    state = AsyncValue.data(state.value!.copyWith(isProcessing: true, lastError: null));
    try {
      final export = await repo.exportAllData();
      await fileService.exportAndShare(export);
      state = AsyncValue.data(state.value!.copyWith(isProcessing: false));
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(isProcessing: false, lastError: e.toString()));
    }
  }

  Future<void> importData() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final fileService = ref.read(fileServiceProvider);

    state = AsyncValue.data(state.value!.copyWith(isProcessing: true, lastError: null));
    try {
      final data = await fileService.pickAndLoadBackup();
      if (data != null) {
        await repo.importData(data);
        state = AsyncValue.data(state.value!.copyWith(isProcessing: false));
      } else {
        state = AsyncValue.data(state.value!.copyWith(isProcessing: false));
      }
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(isProcessing: false, lastError: "Import failed: $e"));
    }
  }

  Future<void> deleteAllData() async {
    final repo = ref.read(openJournalRepositoryProvider);
    state = AsyncValue.data(state.value!.copyWith(isProcessing: true));
    await repo.deleteAllData();
    state = AsyncValue.data(state.value!.copyWith(isProcessing: false));
  }
}

final settingsProvider = AsyncNotifierProvider.autoDispose<SettingsNotifier, SettingsState>(() {
  return SettingsNotifier();
});

final themeModeProvider = Provider.autoDispose<ThemeMode>((ref) {
  final settings = ref.watch(settingsProvider).value;
  if (settings == null) return ThemeMode.system;
  switch (settings.themeMode) {
    case AppThemeMode.system: return ThemeMode.system;
    case AppThemeMode.light: return ThemeMode.light;
    case AppThemeMode.dark: return ThemeMode.dark;
  }
});
