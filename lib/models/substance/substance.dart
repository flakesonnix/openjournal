import 'package:json_annotation/json_annotation.dart';
import 'administration_route.dart';
import 'roa.dart';
import 'tolerance.dart';
import 'interactions.dart';

part 'substance.g.dart';

@JsonSerializable()
class Substance {
  final String name;
  final List<String> commonNames;
  final String url;
  final bool isApproved;
  final Tolerance? tolerance;
  final List<String> crossTolerances;
  final String? addictionPotential;
  final List<String> toxicities;
  final List<String> categories;
  final String? summary;
  final String? effectsSummary;
  final String? dosageRemark;
  final String? generalRisks;
  final String? longtermRisks;
  final List<String> saferUse;
  final Interactions? interactions;
  final List<Roa> roas;

  Substance({
    required this.name,
    required this.commonNames,
    required this.url,
    required this.isApproved,
    this.tolerance,
    required this.crossTolerances,
    this.addictionPotential,
    required this.toxicities,
    required this.categories,
    this.summary,
    this.effectsSummary,
    this.dosageRemark,
    this.generalRisks,
    this.longtermRisks,
    required this.saferUse,
    this.interactions,
    required this.roas,
  });

  factory Substance.fromJson(Map<String, dynamic> json) => _$SubstanceFromJson(json);
  Map<String, dynamic> toJson() => _$SubstanceToJson(this);

  Roa? getRoa(AdministrationRoute route) {
    for (var roa in roas) {
      if (roa.route == route) return roa;
    }
    return null;
  }

  bool get hasInteractions {
    final intr = interactions;
    if (intr == null) return false;
    return intr.uncertain.isNotEmpty || intr.unsafe.isNotEmpty || intr.dangerous.isNotEmpty;
  }

  bool get isHallucinogen {
    const hallucinogens = {
      'hallucinogen',
      'psychedelic',
      'dissociative',
      'deliriant',
    };
    return categories.any((cat) => hallucinogens.contains(cat.toLowerCase()));
  }

  bool get isStimulant {
    const stimulants = {
      'stimulant',
    };
    return categories.any((cat) => stimulants.contains(cat.toLowerCase()));
  }
}
