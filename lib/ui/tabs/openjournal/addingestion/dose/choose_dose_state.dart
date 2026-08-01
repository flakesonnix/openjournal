import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/models/substance/roa_dose.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:collection/collection.dart';

class ChooseDoseState {
  final Substance substance;
  final AdministrationRoute route;
  final RoaDose? roaDose;
  final List<CustomUnit> customUnits;
  final String doseText;
  final String estimatedDoseStandardDeviationText;
  final String purityText;
  final String units;
  final bool isEstimate;

  ChooseDoseState({
    required this.substance,
    required this.route,
    this.roaDose,
    this.customUnits = const [],
    this.doseText = "",
    this.estimatedDoseStandardDeviationText = "",
    this.purityText = "100",
    this.units = "",
    this.isEstimate = false,
  });

  double? get dose => double.tryParse(doseText.replaceAll(',', '.'));
  double? get estimatedDoseStandardDeviation => double.tryParse(estimatedDoseStandardDeviationText.replaceAll(',', '.'));
  double? get purity => double.tryParse(purityText.replaceAll(',', '.'));

  bool get isPurityValid {
    final p = purity;
    return p != null && p > 0 && p <= 100;
  }

  bool get isValidDose => dose != null;

  String? get impureDoseWithUnit {
    final d = dose;
    final p = purity;
    if (d == null || p == null || p <= 0) return null;
    final result = (d / p) * 100;
    return "${result.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '')} impure ${units}";
  }

  DoseClass? get currentDoseClass => roaDose?.getDoseClass(dose, units);

  ChooseDoseState copyWith({
    List<CustomUnit>? customUnits,
    String? doseText,
    String? estimatedDoseStandardDeviationText,
    String? purityText,
    String? units,
    bool? isEstimate,
  }) {
    return ChooseDoseState(
      substance: substance,
      route: route,
      roaDose: roaDose,
      customUnits: customUnits ?? this.customUnits,
      doseText: doseText ?? this.doseText,
      estimatedDoseStandardDeviationText: estimatedDoseStandardDeviationText ?? this.estimatedDoseStandardDeviationText,
      purityText: purityText ?? this.purityText,
      units: units ?? this.units,
      isEstimate: isEstimate ?? this.isEstimate,
    );
  }
}

typedef ChooseDoseArg = ({String substanceName, String routeName});

class ChooseDoseNotifier extends AutoDisposeFamilyAsyncNotifier<ChooseDoseState, ChooseDoseArg> {
  @override
  FutureOr<ChooseDoseState> build(ChooseDoseArg arg) async {
    final substanceService = ref.watch(substanceServiceProvider);
    final repo = ref.watch(openJournalRepositoryProvider);
    final substance = substanceService.substances.firstWhere((s) => s.name == arg.substanceName);
    final route = AdministrationRoute.values.firstWhere((r) => r.name == arg.routeName);
    final roaDose = substance.getRoa(route)?.roaDose;

    final stream = repo.watchCustomUnits(arg.substanceName).map((units) {
      return ChooseDoseState(
        substance: substance,
        route: route,
        roaDose: roaDose,
        customUnits: units.where((u) => u.administrationRoute == route.name).toList(),
        units: roaDose?.units ?? "",
      );
    });

    final first = await stream.first;
    stream.listen((s) {
      state = AsyncValue.data(s.copyWith(
        doseText: state.value?.doseText,
        estimatedDoseStandardDeviationText: state.value?.estimatedDoseStandardDeviationText,
        purityText: state.value?.purityText,
        isEstimate: state.value?.isEstimate,
        units: state.value?.units,
      ));
    });

    return first;
  }

  void updateDoseText(String text) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(doseText: text)));
  }

  void updateEstimatedDoseStandardDeviationText(String text) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(estimatedDoseStandardDeviationText: text)));
  }

  void updatePurityText(String text) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(purityText: text)));
  }

  void updateUnits(String text) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(units: text)));
  }

  void setEstimate(bool value) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(isEstimate: value)));
  }
}

final chooseDoseProvider = AsyncNotifierProvider.autoDispose.family<ChooseDoseNotifier, ChooseDoseState, ChooseDoseArg>(() {
  return ChooseDoseNotifier();
});
