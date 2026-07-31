import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:drift/drift.dart';

class AddCustomSubstanceState {
  final String name;
  final String units;
  final String description;

  AddCustomSubstanceState({
    this.name = "",
    this.units = "",
    this.description = "",
  });

  bool get isValid => name.trim().isNotEmpty && units.trim().isNotEmpty;

  AddCustomSubstanceState copyWith({
    String? name,
    String? units,
    String? description,
  }) {
    return AddCustomSubstanceState(
      name: name ?? this.name,
      units: units ?? this.units,
      description: description ?? this.description,
    );
  }
}

class AddCustomSubstanceNotifier extends AutoDisposeNotifier<AddCustomSubstanceState> {
  @override
  AddCustomSubstanceState build() => AddCustomSubstanceState();

  void updateName(String value) => state = state.copyWith(name: value);
  void updateUnits(String value) => state = state.copyWith(units: value);
  void updateDescription(String value) => state = state.copyWith(description: value);

  Future<void> save(Function(String) onDone) async {
    final repo = ref.read(openJournalRepositoryProvider);
    if (state.isValid) {
      await repo.insertCustomSubstance(CustomSubstancesCompanion.insert(
        name: state.name,
        units: state.units,
        description: state.description,
      ));
      onDone(state.name);
    }
  }
}

final addCustomSubstanceProvider = NotifierProvider.autoDispose<AddCustomSubstanceNotifier, AddCustomSubstanceState>(() {
  return AddCustomSubstanceNotifier();
});
