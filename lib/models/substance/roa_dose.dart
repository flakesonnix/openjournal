import 'dart:math';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'roa_dose.g.dart';

enum DoseClass {
  threshold,
  light,
  common,
  strong,
  heavy;

  String get description {
    switch (this) {
      case DoseClass.threshold:
        return "A threshold dose is the dose at which the mental and physical alterations produced by the substance first become apparent.\nThese effects are distinctly beyond that of placebo but may still be ignored with some effort by directing one's focus towards the external environment.\nSubjects may perceive a vague sense of \"something\" or anticipatory energy building up in the background at this level.";
      case DoseClass.light:
        return "A light dose produces a state which is somewhat distinct from sobriety but does not threaten to override the subject's ordinary awareness.\nThe effects can be ignored by increasing the focus one directs towards the external environment and performing complex tasks.\nThe subject may have to pay particular attention for the substance's effects to be perceptible, or they may be slightly noticeable but will not insist upon the subject's attention.";
      case DoseClass.common:
        return "A common dose is the dose at which the effects and nature of the substance is quite clear and distinct; the subject's ordinary awareness slips and ignoring its action becomes difficult.\nThe subject will generally be able to partake in regular behaviors and remain functional and able to communicate, although this can depend on the individual.\nThe effects can be allowed to occupy a predominant role or they may be suppressed and made secondary to other chosen activities with sufficient effort or in case of an emergency.";
      case DoseClass.strong:
        return "A strong dose renders its subject mostly incapable of functioning, interacting normally, or thinking in a straightforward manner.\nThe effects of the substance are clear and can no longer be ignored or suppressed, leaving the subject entirely engaged in the experience regardless of their desire or volition. Negative effects become more common at this level.\nAs subjects are not able to alter the trajectory of their behavior at strong doses, it is vital that they have prepared their environment and activities in advance as well as taken any precautionary measures.";
      case DoseClass.heavy:
        return "A heavy dose is the upper limit of what a substance is capable of producing in terms of psychoactive effects; doses past this range are associated with rapidly increasing side effects and marginal desirable effects.\nDepending on the substance consumed, the user may be rendered incapable of functioning and communicating in addition to experiencing extremely uncomfortable side effects that overshadow the positive effects experienced at lower doses.\nIt is absolutely vital to employ harm reduction measures with heavy doses as the user will likely be unable to properly take care of themselves in the event of an emergency. Trip sitters are strongly advised.\nUsers should also be aware that the line between a heavy dose and overdose is often very blurry and they are placing themselves at a significantly higher risk of injury, hospitalization, and death whenever they choose to take a heavy dose.\nThe desire or compulsion to regularly take heavy doses (\"chronic use\") may also be an indicator of tolerance, addiction or other mental health problems.";
    }
  }

  Color getColor(bool isDarkTheme) {
    switch (this) {
      case DoseClass.threshold:
        return isDarkTheme ? const Color(0xFF64D2FF) : const Color(0xFF32ADE6);
      case DoseClass.light:
        return isDarkTheme ? const Color(0xFF30D158) : const Color(0xFF34C759);
      case DoseClass.common:
        return isDarkTheme ? const Color(0xFFFFD60A) : const Color(0xFFFFCC00);
      case DoseClass.strong:
        return isDarkTheme ? const Color(0xFFFF9F0A) : const Color(0xFFFF9500);
      case DoseClass.heavy:
        return isDarkTheme ? const Color(0xFFFF453A) : const Color(0xFFFF3B30);
    }
  }
}

@JsonSerializable()
class RoaDose {
  final String units;
  final double? lightMin;
  final double? commonMin;
  final double? strongMin;
  final double? heavyMin;

  RoaDose({
    required this.units,
    this.lightMin,
    this.commonMin,
    this.strongMin,
    this.heavyMin,
  });

  factory RoaDose.fromJson(Map<String, dynamic> json) => _$RoaDoseFromJson(json);
  Map<String, dynamic> toJson() => _$RoaDoseToJson(this);

  DoseClass? getDoseClass(double? ingestionDose, [String? ingestionUnits]) {
    final effectiveUnits = ingestionUnits ?? units;
    if (effectiveUnits != units || ingestionDose == null) return null;

    if (lightMin != null && ingestionDose < lightMin!) return DoseClass.threshold;
    if (commonMin != null && ingestionDose < commonMin!) return DoseClass.light;
    if (strongMin != null && ingestionDose < strongMin!) return DoseClass.common;
    if (heavyMin != null && ingestionDose < heavyMin!) return DoseClass.strong;
    if (heavyMin != null) return DoseClass.heavy;

    return null;
  }

  int? getNumDots(double? ingestionDose, [String? ingestionUnits]) {
    final effectiveUnits = ingestionUnits ?? units;
    if (effectiveUnits != units || ingestionDose == null) return null;

    if (lightMin != null && ingestionDose < lightMin!) return 0;
    if (commonMin != null && ingestionDose < commonMin!) return 1;
    if (strongMin != null && ingestionDose < strongMin!) return 2;
    if (heavyMin != null && ingestionDose < heavyMin!) return 3;
    if (heavyMin != null) {
      final timesHeavy = (ingestionDose / heavyMin!).floor();
      final rest = ingestionDose % heavyMin!;
      return (timesHeavy * 4) + _getNumDotsUpTo4(rest);
    }
    if (strongMin != null) return 3;
    if (commonMin != null) return 2;
    if (lightMin != null) return 1;

    return null;
  }

  int _getNumDotsUpTo4(double dose) {
    if (lightMin != null && dose < lightMin!) return 0;
    if (commonMin != null && dose < commonMin!) return 1;
    if (strongMin != null && dose < strongMin!) return 2;
    if (heavyMin != null && dose < heavyMin!) return 3;
    return 0;
  }

  double? get averageCommonDose {
    if (commonMin != null && strongMin != null) {
      return (commonMin! + strongMin!) / 2;
    }
    return commonMin ?? strongMin;
  }

  double? getStrengthRelativeToCommonDose(double dose) {
    final avg = averageCommonDose;
    if (avg != null && avg > 0.0000001) {
      return dose / avg;
    }
    return null;
  }
}
