import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:drift/drift.dart';

class TimedNoteState {
  final int? id; // null for new
  final String note;
  final DateTime time;
  final AdaptiveColor color;
  final bool isPartOfTimeline;
  final bool isLoading;

  TimedNoteState({
    this.id,
    this.note = "",
    required this.time,
    this.color = AdaptiveColor.blue,
    this.isPartOfTimeline = true,
    this.isLoading = false,
  });

  bool get isValid => note.trim().isNotEmpty;

  TimedNoteState copyWith({
    String? note,
    DateTime? time,
    AdaptiveColor? color,
    bool? isPartOfTimeline,
    bool? isLoading,
  }) {
    return TimedNoteState(
      id: id,
      note: note ?? this.note,
      time: time ?? this.time,
      color: color ?? this.color,
      isPartOfTimeline: isPartOfTimeline ?? this.isPartOfTimeline,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

typedef TimedNoteArg = ({int? noteId, int experienceId});

class TimedNoteNotifier extends AutoDisposeFamilyAsyncNotifier<TimedNoteState, TimedNoteArg> {
  @override
  FutureOr<TimedNoteState> build(TimedNoteArg arg) async {
    if (arg.noteId == null) {
      return TimedNoteState(time: DateTime.now());
    }

    final db = ref.watch(databaseProvider);
    final note = await (db.select(db.timedNotes)..where((t) => t.id.equals(arg.noteId!))).getSingle();

    return TimedNoteState(
      id: note.id,
      note: note.note,
      time: note.time,
      color: AdaptiveColor.values.firstWhere((c) => c.name == note.color, orElse: () => AdaptiveColor.blue),
      isPartOfTimeline: note.isPartOfTimeline,
    );
  }

  void updateNote(String val) => state = AsyncValue.data(state.value!.copyWith(note: val));
  void updateTime(DateTime val) => state = AsyncValue.data(state.value!.copyWith(time: val));
  void updateColor(AdaptiveColor val) => state = AsyncValue.data(state.value!.copyWith(color: val));
  void updateIsPartOfTimeline(bool val) => state = AsyncValue.data(state.value!.copyWith(isPartOfTimeline: val));

  Future<void> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final s = state.value!;

    final companion = TimedNotesCompanion.insert(
      id: s.id == null ? const Value.absent() : Value(s.id!),
      note: s.note,
      time: s.time,
      color: s.color, // Passing AdaptiveColor enum directly
      experienceId: arg.experienceId,
      isPartOfTimeline: s.isPartOfTimeline,
      creationDate: DateTime.now(),
    );

    if (s.id == null) {
      await repo.insertTimedNote(companion);
    } else {
      await repo.updateTimedNote(companion);
    }
  }

  Future<void> delete() async {
    if (arg.noteId != null) {
      final repo = ref.read(openJournalRepositoryProvider);
      await repo.deleteTimedNote(arg.noteId!);
    }
  }
}

final timedNoteProvider = AsyncNotifierProvider.autoDispose.family<TimedNoteNotifier, TimedNoteState, TimedNoteArg>(() {
  return TimedNoteNotifier();
});
