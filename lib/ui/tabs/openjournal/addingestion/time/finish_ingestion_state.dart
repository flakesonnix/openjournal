import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

enum IngestionTimePickerOption { pointInTime, timeRange }

class FinishIngestionState {
  final DateTime startTime;
  final DateTime endTime;
  final IngestionTimePickerOption timeOption;
  final List<ExperienceListItem> experiencesInRange;
  final ExperienceListItem? selectedExperience;
  final String enteredTitle;
  final String consumerName;
  final List<String> recentConsumerNames;
  final String note;
  final List<String> recentNotes;
  final AdaptiveColor selectedColor;
  final bool isShowingColorPicker;
  final bool isLoading;

  FinishIngestionState({
    required this.startTime,
    required this.endTime,
    this.timeOption = IngestionTimePickerOption.pointInTime,
    this.experiencesInRange = const [],
    this.selectedExperience,
    this.enteredTitle = "",
    this.consumerName = "",
    this.recentConsumerNames = const [],
    this.note = "",
    this.recentNotes = const [],
    this.selectedColor = AdaptiveColor.blue,
    this.isShowingColorPicker = false,
    this.isLoading = true,
  });

  bool get isEnteredTitleOk => enteredTitle.isNotEmpty;

  FinishIngestionState copyWith({
    DateTime? startTime,
    DateTime? endTime,
    IngestionTimePickerOption? timeOption,
    List<ExperienceListItem>? experiencesInRange,
    ExperienceListItem? selectedExperience,
    String? enteredTitle,
    String? consumerName,
    List<String>? recentConsumerNames,
    String? note,
    List<String>? recentNotes,
    AdaptiveColor? selectedColor,
    bool? isShowingColorPicker,
    bool? isLoading,
  }) {
    return FinishIngestionState(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeOption: timeOption ?? this.timeOption,
      experiencesInRange: experiencesInRange ?? this.experiencesInRange,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      enteredTitle: enteredTitle ?? this.enteredTitle,
      consumerName: consumerName ?? this.consumerName,
      recentConsumerNames: recentConsumerNames ?? this.recentConsumerNames,
      note: note ?? this.note,
      recentNotes: recentNotes ?? this.recentNotes,
      selectedColor: selectedColor ?? this.selectedColor,
      isShowingColorPicker: isShowingColorPicker ?? this.isShowingColorPicker,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

typedef FinishIngestionArg = ({
  String substanceName,
  AdministrationRoute route,
  double? dose,
  String? units,
  bool isEstimate,
  double? estimatedDoseStandardDeviation,
  int? customUnitId,
  int? experienceId,
});

class FinishIngestionNotifier extends AutoDisposeFamilyAsyncNotifier<FinishIngestionState, FinishIngestionArg> {
  @override
  FutureOr<FinishIngestionState> build(FinishIngestionArg arg) async {
    final repo = ref.watch(openJournalRepositoryProvider);

    final startTime = DateTime.now();
    final endTime = startTime.add(const Duration(minutes: 30));
    final defaultTitle = DateFormat('dd MMMM yyyy').format(startTime);

    final recentConsumers = await repo.getRecentConsumerNames();
    final recentNotes = await repo.getRecentNotesForSubstance(arg.substanceName);
    final companion = await repo.getSubstanceCompanion(arg.substanceName);

    final stateValue = FinishIngestionState(
      startTime: startTime,
      endTime: endTime,
      enteredTitle: defaultTitle,
      recentConsumerNames: recentConsumers,
      recentNotes: recentNotes,
      selectedColor: companion?.color ?? AdaptiveColor.blue,
      isShowingColorPicker: companion == null,
      isLoading: false,
    );

    // Initial search for experiences in range
    final inRange = await repo.getExperiencesInRange(
      startTime.subtract(const Duration(days: 3)),
      startTime.add(const Duration(days: 1)),
    );

    ExperienceListItem? selectedExp;
    if (arg.experienceId != null) {
      selectedExp = inRange.firstWhere((e) => e.experience.id == arg.experienceId);
    } else {
      // Logic from Kotlin to find best matching experience
      selectedExp = inRange.firstWhereOrNull((e) {
        if (e.ingestions.isEmpty) return false;
        final sorted = e.ingestions.map((i) => i.ingestion.time).toList()..sort();
        final first = sorted.first;
        final last = sorted.last;
        final upper = last.add(const Duration(hours: 3)); // max of (first + 15h, last + 3h) simplified
        final lower = first.subtract(const Duration(hours: 3));
        return startTime.isAfter(lower) && startTime.isBefore(upper);
      });
    }

    return stateValue.copyWith(
      experiencesInRange: inRange,
      selectedExperience: selectedExp,
    );
  }

  void updateStartTime(DateTime time) async {
    final repo = ref.read(openJournalRepositoryProvider);
    state.whenData((s) async {
      final newState = s.copyWith(startTime: time);
      final inRange = await repo.getExperiencesInRange(
        time.subtract(const Duration(days: 3)),
        time.add(const Duration(days: 1)),
      );
      state = AsyncValue.data(newState.copyWith(experiencesInRange: inRange));
    });
  }

  void updateEndTime(DateTime time) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(endTime: time)));
  }

  void setTimeOption(IngestionTimePickerOption option) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(timeOption: option)));
  }

  void selectExperience(ExperienceListItem? exp) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(selectedExperience: exp)));
  }

  void updateTitle(String title) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(enteredTitle: title)));
  }

  void updateConsumerName(String name) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(consumerName: name)));
  }

  void updateNote(String note) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(note: note)));
  }

  void updateColor(AdaptiveColor color) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(selectedColor: color)));
  }

  Future<int> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final s = state.value!;

    final ingestion = IngestionsCompanion(
      substanceName: Value(arg.substanceName),
      time: Value(s.startTime),
      endTime: Value(s.timeOption == IngestionTimePickerOption.timeRange ? s.endTime : null),
      administrationRoute: Value(arg.route.name),
      dose: Value(arg.dose),
      isDoseAnEstimate: Value(arg.isEstimate),
      estimatedDoseStandardDeviation: Value(arg.estimatedDoseStandardDeviation),
      units: Value(arg.units),
      experienceId: Value(s.selectedExperience?.experience.id ?? 0),
      notes: Value(s.note),
      consumerName: Value(s.consumerName.isEmpty ? null : s.consumerName),
      customUnitId: Value(arg.customUnitId),
      creationDate: Value(DateTime.now()),
    );

    ExperiencesCompanion? newExp;
    if (s.selectedExperience == null) {
      newExp = ExperiencesCompanion.insert(
        title: s.enteredTitle,
        textContent: "",
        creationDate: DateTime.now(),
        sortDate: s.startTime,
        isFavorite: false,
      );
    }

    final companion = SubstanceCompanionsCompanion.insert(
      substanceName: arg.substanceName,
      color: s.selectedColor,
    );

    return await repo.saveIngestionFlow(
      ingestion: ingestion,
      newExperience: newExp,
      companion: companion,
    );
  }
}

final finishIngestionProvider = AsyncNotifierProvider.autoDispose.family<FinishIngestionNotifier, FinishIngestionState, FinishIngestionArg>(() {
  return FinishIngestionNotifier();
});
