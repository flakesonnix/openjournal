import 'package:openjournal/models/substance/interaction_type.dart';
import 'package:openjournal/models/substance/interactions.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InteractionChecker {
  final SubstanceService _substanceService;

  InteractionChecker(this._substanceService);

  Interaction? getInteractionBetween(String aName, String bName) {
    if (aName == bName) return null;

    final interactionFromAToB = _getInteractionFromAToB(aName, bName);
    final interactionFromBToA = _getInteractionFromAToB(bName, aName);

    if (interactionFromAToB != null && interactionFromBToA != null) {
      final isAtoB = interactionFromAToB.dangerCount >= interactionFromBToA.dangerCount;
      final interactionType = isAtoB ? interactionFromAToB : interactionFromBToA;
      return Interaction(
        aName: aName,
        bName: bName,
        interactionType: interactionType,
      );
    } else if (interactionFromAToB != null) {
      return Interaction(
        aName: aName,
        bName: bName,
        interactionType: interactionFromAToB,
      );
    } else if (interactionFromBToA != null) {
      return Interaction(
        aName: aName,
        bName: bName,
        interactionType: interactionFromBToA,
      );
    } else {
      return null;
    }
  }

  InteractionType? _getInteractionFromAToB(String aName, String bName) {
    final substanceA = _substanceService.substances.where((s) => s.name == aName).firstOrNull;
    if (substanceA != null) {
      final directInteraction = _getDirectInteraction(substanceA.interactions, bName);
      if (directInteraction != null) return directInteraction;

      final wildcardInteraction = _getWildcardInteraction(substanceA.interactions, bName);
      if (wildcardInteraction != null) return wildcardInteraction;

      final substanceB = _substanceService.substances.where((s) => s.name == bName).firstOrNull;
      if (substanceB != null) {
        final classInteraction = _getClassInteraction(substanceA.interactions, substanceB.categories);
        if (classInteraction != null) return classInteraction;
      }
    }
    return null;
  }

  InteractionType? _getDirectInteraction(Interactions? interactions, String substanceName) {
    if (interactions == null) return null;
    if (_isDirectMatch(interactions.dangerous, substanceName)) return InteractionType.dangerous;
    if (_isDirectMatch(interactions.unsafe, substanceName)) return InteractionType.unsafe;
    if (_isDirectMatch(interactions.uncertain, substanceName)) return InteractionType.uncertain;
    return null;
  }

  InteractionType? _getWildcardInteraction(Interactions? interactions, String substanceName) {
    if (interactions == null) return null;
    if (_isWildcardMatch(interactions.dangerous, substanceName)) return InteractionType.dangerous;
    if (_isWildcardMatch(interactions.unsafe, substanceName)) return InteractionType.unsafe;
    if (_isWildcardMatch(interactions.uncertain, substanceName)) return InteractionType.uncertain;
    return null;
  }

  InteractionType? _getClassInteraction(Interactions? interactions, List<String> categories) {
    if (interactions == null) return null;
    if (_isClassMatch(interactions.dangerous, categories)) return InteractionType.dangerous;
    if (_isClassMatch(interactions.unsafe, categories)) return InteractionType.unsafe;
    if (_isClassMatch(interactions.uncertain, categories)) return InteractionType.uncertain;
    return null;
  }

  bool _isClassMatch(List<String> interactions, List<String> categories) {
    final extendedInteractions = _extendAndCleanInteractions(interactions);
    return categories.any((categoryName) =>
        extendedInteractions.any((interactionName) =>
            interactionName.toLowerCase().contains(categoryName.toLowerCase())));
  }

  bool _isWildcardMatch(List<String> interactions, String substanceName) {
    final extendedInteractions = _extendAndCleanInteractions(interactions);
    return extendedInteractions.where((i) => i.contains('x') || i.contains('X')).any((interaction) {
      final pattern = interaction.replaceAll('x', '.*').replaceAll('X', '.*');
      return RegExp('^$pattern\$', caseSensitive: false).hasMatch(substanceName);
    });
  }

  bool _isDirectMatch(List<String> interactions, String substanceName) {
    final extendedInteractions = _extendAndCleanInteractions(interactions);
    return extendedInteractions.contains(substanceName);
  }

  List<String> _extendAndCleanInteractions(List<String> interactions) {
    return interactions.expand((name) {
      switch (name) {
        case "Substituted amphetamines":
          return _substitutedAmphetamines;
        case "Serotonin releasers":
          return _serotoninReleasers;
        case "Tricyclic antidepressants":
          return _tricyclicAntidepressants;
        default:
          return [name];
      }
    }).toList().toSet().toList();
  }

  static const _serotoninReleasers = ["MDMA", "MDA", "Mephedrone"];

  static const _tricyclicAntidepressants = [
    "Amitriptyline",
    "Clomipramine",
    "Dosulepin",
    "Doxepin",
    "Imipramine",
    "Lofepramine",
    "Nortriptyline"
  ];

  static const _substitutedAmphetamines = [
    "Amphetamine", "Methamphetamine", "Ethylamphetamine", "Propylamphetamine",
    "Isopropylamphetamine", "Bromo-DragonFLY", "Lisdexamfetamine", "Clobenzorex",
    "Dimethylamphetamine", "Selegiline", "Benzphetamine", "Ortetamine",
    "3-Methylamphetamine", "4-Methylamphetamine", "4-MMA", "Xylopropamine",
    "ß-methylamphetamine", "3-phenylmethamphetamine", "2-FA", "2-FMA", "2-FEA",
    "3-FA", "3-FMA", "3-FEA", "Fenfluramine", "Norfenfluramine", "4-FA", "4-FMA",
    "4-CA", "4-BA", "4-IA", "DCA", "4-HA", "4-HMA", "3,4-DHA", "OMA", "3-MA",
    "MMMA", "MMA", "PMA", "PMMA", "PMEA", "4-ETA", "TMA-2", "TMA-6", "4-MTA",
    "5-API", "Cathine", "Phenmetrazine", "3-FPM", "Prolintane"
  ];
}

final interactionCheckerProvider = Provider<InteractionChecker>((ref) {
  final service = ref.watch(substanceServiceProvider);
  return InteractionChecker(service);
});
