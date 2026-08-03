import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/roa_dose.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/utils/number_utils.dart';

class ChooseDoseCustomUnitState {
  final CustomUnit customUnit;
  final RoaDose? roaDose;
  final String doseText;
  final String estimatedDoseDeviationText;
  final bool isEstimate;

  ChooseDoseCustomUnitState({
    required this.customUnit,
    this.roaDose,
    this.doseText = "",
    this.estimatedDoseDeviationText = "",
    this.isEstimate = false,
  });

  double? get dose => double.tryParse(doseText.replaceAll(',', '.'));
  double? get estimatedDoseDeviation => double.tryParse(estimatedDoseDeviationText.replaceAll(',', '.'));

  bool get isValidDose => dose != null;

  double? get calculatedPureDose {
    final d = dose;
    final unitDose = customUnit.dose;
    if (d == null || unitDose == null) return null;
    return d * unitDose;
  }

  String get calculationText {
    final d = calculatedPureDose;
    if (d == null) return "";
    return "${dose!.toReadableString()} ${customUnit.unit} x ${customUnit.dose!.toReadableString()} ${customUnit.originalUnit} = ${d.toReadableString()} ${customUnit.originalUnit}";
  }

  DoseClass? get currentDoseClass => roaDose?.getDoseClass(calculatedPureDose, customUnit.originalUnit);

  ChooseDoseCustomUnitState copyWith({
    String? doseText,
    String? estimatedDoseDeviationText,
    bool? isEstimate,
  }) {
    return ChooseDoseCustomUnitState(
      customUnit: customUnit,
      roaDose: roaDose,
      doseText: doseText ?? this.doseText,
      estimatedDoseDeviationText: estimatedDoseDeviationText ?? this.estimatedDoseDeviationText,
      isEstimate: isEstimate ?? this.isEstimate,
    );
  }
}

class ChooseDoseCustomUnitNotifier extends AutoDisposeFamilyAsyncNotifier<ChooseDoseCustomUnitState, int> {
  @override
  FutureOr<ChooseDoseCustomUnitState> build(int customUnitId) async {
    final db = ref.watch(databaseProvider);
    final substanceService = ref.watch(substanceServiceProvider);

    final unit = await (db.select(db.customUnits)..where((t) => t.id.equals(customUnitId))).getSingle();
    final substance = substanceService.substances.firstWhere((s) => s.name == unit.substanceName);
    final route = AdministrationRoute.values.firstWhere((r) => r.name == unit.administrationRoute);
    final roaDose = substance.getRoa(route)?.roaDose;

    return ChooseDoseCustomUnitState(
      customUnit: unit,
      roaDose: roaDose,
    );
  }

  void updateDose(String val) => state = AsyncValue.data(state.value!.copyWith(doseText: val));
  void updateDeviation(String val) => state = AsyncValue.data(state.value!.copyWith(estimatedDoseDeviationText: val));
  void setEstimate(bool val) => state = AsyncValue.data(state.value!.copyWith(isEstimate: val));
}

final chooseDoseCustomUnitProvider = AsyncNotifierProvider.autoDispose.family<ChooseDoseCustomUnitNotifier, ChooseDoseCustomUnitState, int>(() {
  return ChooseDoseCustomUnitNotifier();
});
