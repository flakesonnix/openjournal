import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/substance/administration_route.dart';

sealed class Suggestion {
  final DateTime sortInstant;
  Suggestion({required this.sortInstant});

  bool isInSearch(String searchText, List<String> substanceNames);
}

class PureSubstanceSuggestion extends Suggestion {
  final AdministrationRoute administrationRoute;
  final String substanceName;
  final AdaptiveColor adaptiveColor;
  final List<DoseAndUnit> dosesAndUnit;

  PureSubstanceSuggestion({
    required this.administrationRoute,
    required this.substanceName,
    required this.adaptiveColor,
    required this.dosesAndUnit,
    required DateTime sortInstant,
  }) : super(sortInstant: sortInstant);

  @override
  bool isInSearch(String searchText, List<String> substanceNames) {
    return substanceNames.contains(substanceName);
  }
}

class CustomUnitSuggestion extends Suggestion {
  final CustomUnit customUnit;
  final AdaptiveColor adaptiveColor;
  final List<CustomUnitDoseSuggestion> dosesAndUnit;

  CustomUnitSuggestion({
    required this.customUnit,
    required this.adaptiveColor,
    required this.dosesAndUnit,
    required DateTime sortInstant,
  }) : super(sortInstant: sortInstant);

  @override
  bool isInSearch(String searchText, List<String> substanceNames) {
    if (searchText.isEmpty) return true;
    if (substanceNames.contains(customUnit.substanceName)) return true;

    final lowerQuery = searchText.toLowerCase();
    return customUnit.name.toLowerCase().contains(lowerQuery) ||
        customUnit.unit.toLowerCase().contains(lowerQuery) ||
        customUnit.note.toLowerCase().contains(lowerQuery);
  }
}

class CustomSubstanceSuggestion extends Suggestion {
  final AdministrationRoute administrationRoute;
  final CustomSubstance customSubstance;
  final AdaptiveColor adaptiveColor;
  final List<DoseAndUnit> dosesAndUnit;

  CustomSubstanceSuggestion({
    required this.administrationRoute,
    required this.customSubstance,
    required this.adaptiveColor,
    required this.dosesAndUnit,
    required DateTime sortInstant,
  }) : super(sortInstant: sortInstant);

  @override
  bool isInSearch(String searchText, List<String> substanceNames) {
    if (searchText.isEmpty) return true;
    return customSubstance.name.toLowerCase().contains(searchText.toLowerCase());
  }
}

class DoseAndUnit {
  final double? dose;
  final String unit;
  final bool isEstimate;
  final double? estimatedDoseStandardDeviation;

  DoseAndUnit({
    this.dose,
    required this.unit,
    required this.isEstimate,
    this.estimatedDoseStandardDeviation,
  });

  String get comparatorValue => '${dose ?? "U"}$unit$isEstimate$estimatedDoseStandardDeviation';
}

class CustomUnitDoseSuggestion {
  final double? dose;
  final bool isEstimate;
  final double? estimatedDoseStandardDeviation;

  CustomUnitDoseSuggestion({
    this.dose,
    required this.isEstimate,
    this.estimatedDoseStandardDeviation,
  });

  String get comparatorValue => '${dose ?? "U"}$isEstimate$estimatedDoseStandardDeviation';
}
