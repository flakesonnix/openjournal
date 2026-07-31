import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/finish_ingestion_state.dart';
import 'package:drift/drift.dart';

class EditIngestionState {
  final Ingestion ingestion;
  final String doseText;
  final String estimatedDoseSDText;
  final bool isEstimate;
  final String notes;
  final DateTime startTime;
  final DateTime? endTime;
  final IngestionTimePickerOption timeOption;
  final String consumerName;
  final bool isLoading;

  EditIngestionState({
    required this.ingestion,
    this.doseText = "",
    this.estimatedDoseSDText = "",
    this.isEstimate = false,
    this.notes = "",
    required this.startTime,
    this.endTime,
    this.timeOption = IngestionTimePickerOption.pointInTime,
    this.consumerName = "",
    this.isLoading = true,
  });

  bool get isValid => double.tryParse(doseText.replaceAll(',', '.')) != null;

  EditIngestionState copyWith({
    Ingestion? ingestion,
    String? doseText,
    String? estimatedDoseSDText,
    bool? isEstimate,
    String? notes,
    DateTime? startTime,
    DateTime? endTime,
    IngestionTimePickerOption? timeOption,
    String? consumerName,
    bool? isLoading,
  }) {
    return EditIngestionState(
      ingestion: ingestion ?? this.ingestion,
      doseText: doseText ?? this.doseText,
      estimatedDoseSDText: estimatedDoseSDText ?? this.estimatedDoseSDText,
      isEstimate: isEstimate ?? this.isEstimate,
      notes: notes ?? this.notes,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeOption: timeOption ?? this.timeOption,
      consumerName: consumerName ?? this.consumerName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class EditIngestionNotifier extends AutoDisposeFamilyAsyncNotifier<EditIngestionState, int> {
  @override
  FutureOr<EditIngestionState> build(int ingestionId) async {
    final db = ref.watch(databaseProvider);
    final ing = await (db.select(db.ingestions)..where((t) => t.id.equals(ingestionId))).getSingle();

    return EditIngestionState(
      ingestion: ing,
      doseText: ing.dose?.toString() ?? "",
      estimatedDoseSDText: ing.estimatedDoseStandardDeviation?.toString() ?? "",
      isEstimate: ing.isDoseAnEstimate,
      notes: ing.notes ?? "",
      startTime: ing.time,
      endTime: ing.endTime,
      timeOption: ing.endTime != null ? IngestionTimePickerOption.timeRange : IngestionTimePickerOption.pointInTime,
      consumerName: ing.consumerName ?? "",
      isLoading: false,
    );
  }

  void updateDose(String val) => state = AsyncValue.data(state.value!.copyWith(doseText: val));
  void updateSD(String val) => state = AsyncValue.data(state.value!.copyWith(estimatedDoseSDText: val));
  void setEstimate(bool val) => state = AsyncValue.data(state.value!.copyWith(isEstimate: val));
  void updateNotes(String val) => state = AsyncValue.data(state.value!.copyWith(notes: val));
  void updateStartTime(DateTime val) => state = AsyncValue.data(state.value!.copyWith(startTime: val));
  void updateEndTime(DateTime val) => state = AsyncValue.data(state.value!.copyWith(endTime: val));
  void setTimeOption(IngestionTimePickerOption val) => state = AsyncValue.data(state.value!.copyWith(timeOption: val));
  void updateConsumer(String val) => state = AsyncValue.data(state.value!.copyWith(consumerName: val));

  Future<void> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final s = state.value!;

    await repo.updateIngestion(IngestionsCompanion(
      id: Value(s.ingestion.id),
      dose: Value(double.tryParse(s.doseText.replaceAll(',', '.'))),
      isDoseAnEstimate: Value(s.isEstimate),
      estimatedDoseStandardDeviation: Value(double.tryParse(s.estimatedDoseSDText.replaceAll(',', '.'))),
      notes: Value(s.notes),
      time: Value(s.startTime),
      endTime: Value(s.timeOption == IngestionTimePickerOption.timeRange ? s.endTime : null),
      consumerName: Value(s.consumerName.isEmpty ? null : s.consumerName),
    ));
  }

  Future<void> delete() async {
    final repo = ref.read(openJournalRepositoryProvider);
    await repo.deleteIngestion(arg);
  }
}

final editIngestionProvider = AsyncNotifierProvider.autoDispose.family<EditIngestionNotifier, EditIngestionState, int>(() {
  return EditIngestionNotifier();
});
