import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:drift/drift.dart';

class EditExperienceState {
  final int id;
  final String title;
  final String location;
  final String notes;
  final bool isTitleValid;

  EditExperienceState({
    required this.id,
    this.title = "",
    this.location = "",
    this.notes = "",
    this.isTitleValid = true,
  });

  EditExperienceState copyWith({
    String? title,
    String? location,
    String? notes,
    bool? isTitleValid,
  }) {
    return EditExperienceState(
      id: id,
      title: title ?? this.title,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      isTitleValid: isTitleValid ?? this.isTitleValid,
    );
  }
}

class EditExperienceNotifier extends AutoDisposeFamilyAsyncNotifier<EditExperienceState, int> {
  @override
  FutureOr<EditExperienceState> build(int experienceId) async {
    final repo = ref.watch(openJournalRepositoryProvider);
    final detail = await repo.watchExperienceDetail(experienceId).first;
    final exp = detail.listItem.experience;

    return EditExperienceState(
      id: experienceId,
      title: exp.title,
      location: exp.locationName ?? "",
      notes: exp.textContent,
    );
  }

  void updateTitle(String value) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(title: value, isTitleValid: value.isNotEmpty)));
  }

  void updateLocation(String value) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(location: value)));
  }

  void updateNotes(String value) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(notes: value)));
  }

  Future<void> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final s = state.value!;

    await repo.updateExperience(ExperiencesCompanion(
      id: Value(s.id),
      title: Value(s.title),
      locationName: Value(s.location.isEmpty ? null : s.location),
      textContent: Value(s.notes),
    ));
  }
}

final editExperienceProvider = AsyncNotifierProvider.autoDispose.family<EditExperienceNotifier, EditExperienceState, int>(() {
  return EditExperienceNotifier();
});
