import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/models/substance/roa_dose.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:drift/drift.dart';

class AddCustomUnitState {
  final String substanceName;
  final AdministrationRoute route;
  final String name;
  final String doseText;
  final String estimatedDoseDeviationText;
  final bool isEstimate;
  final String unit;
  final String unitPlural;
  final String originalUnit;
  final String note;
  final bool isArchived;
  final RoaDose? roaDose;

  AddCustomUnitState({
    required this.substanceName,
    required this.route,
    this.name = "",
    this.doseText = "",
    this.estimatedDoseDeviationText = "",
    this.isEstimate = false,
    this.unit = "",
    this.unitPlural = "",
    this.originalUnit = "mg",
    this.note = "",
    this.isArchived = false,
    this.roaDose,
  });

  bool get isValid => name.isNotEmpty && unit.isNotEmpty && double.tryParse(doseText.replaceAll(',', '.')) != null;

  AddCustomUnitState copyWith({
    String? name,
    String? doseText,
    String? estimatedDoseDeviationText,
    bool? isEstimate,
    String? unit,
    String? unitPlural,
    String? originalUnit,
    String? note,
    bool? isArchived,
  }) {
    return AddCustomUnitState(
      substanceName: substanceName,
      route: route,
      name: name ?? this.name,
      doseText: doseText ?? this.doseText,
      estimatedDoseDeviationText: estimatedDoseDeviationText ?? this.estimatedDoseDeviationText,
      isEstimate: isEstimate ?? this.isEstimate,
      unit: unit ?? this.unit,
      unitPlural: unitPlural ?? this.unitPlural,
      originalUnit: originalUnit ?? this.originalUnit,
      note: note ?? this.note,
      isArchived: isArchived ?? this.isArchived,
      roaDose: roaDose,
    );
  }
}

typedef AddCustomUnitArg = ({String substanceName, String routeName});

class AddCustomUnitNotifier extends AutoDisposeFamilyAsyncNotifier<AddCustomUnitState, AddCustomUnitArg> {
  @override
  FutureOr<AddCustomUnitState> build(AddCustomUnitArg arg) async {
    final substanceService = ref.watch(substanceServiceProvider);
    final substance = substanceService.substances.firstWhere((s) => s.name == arg.substanceName);
    final route = AdministrationRoute.values.firstWhere((r) => r.name == arg.routeName);
    final roaDose = substance.getRoa(route)?.roaDose;

    return AddCustomUnitState(
      substanceName: arg.substanceName,
      route: route,
      roaDose: roaDose,
      originalUnit: roaDose?.units ?? "mg",
    );
  }

  void updateName(String val) => state = AsyncValue.data(state.value!.copyWith(name: val));
  void updateDose(String val) => state = AsyncValue.data(state.value!.copyWith(doseText: val));
  void updateEstimatedDeviation(String val) => state = AsyncValue.data(state.value!.copyWith(estimatedDoseDeviationText: val));
  void updateIsEstimate(bool val) => state = AsyncValue.data(state.value!.copyWith(isEstimate: val));

  void updateUnit(String val) {
    String plural = val;
    if (val != "mg" && val != "g" && val.toLowerCase() != "ml" && !val.endsWith('s')) {
      plural = "${val}s";
    }
    state = AsyncValue.data(state.value!.copyWith(unit: val, unitPlural: plural));
  }

  void updateUnitPlural(String val) => state = AsyncValue.data(state.value!.copyWith(unitPlural: val));
  void updateOriginalUnit(String val) => state = AsyncValue.data(state.value!.copyWith(originalUnit: val));
  void updateNote(String val) => state = AsyncValue.data(state.value!.copyWith(note: val));
  void updateIsArchived(bool val) => state = AsyncValue.data(state.value!.copyWith(isArchived: val));

  Future<int> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final s = state.value!;

    return await repo.insertCustomUnit(CustomUnitsCompanion.insert(
      substanceName: s.substanceName,
      name: s.name,
      creationDate: DateTime.now(),
      administrationRoute: s.route.name,
      dose: Value(double.tryParse(s.doseText.replaceAll(',', '.'))),
      estimatedDoseStandardDeviation: Value(double.tryParse(s.estimatedDoseDeviationText.replaceAll(',', '.'))),
      isEstimate: s.isEstimate,
      isArchived: s.isArchived,
      unit: s.unit,
      unitPlural: Value(s.unitPlural),
      originalUnit: s.originalUnit,
      note: s.note,
    ));
  }
}

final addCustomUnitProvider = AsyncNotifierProvider.autoDispose.family<AddCustomUnitNotifier, AddCustomUnitState, AddCustomUnitArg>(() {
  return AddCustomUnitNotifier();
});
