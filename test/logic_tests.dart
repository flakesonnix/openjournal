import 'package:flutter_test/flutter_test.dart';
import 'package:openjournal/utils/number_utils.dart';
import 'package:openjournal/utils/date_utils.dart';
import 'package:openjournal/services/interaction_checker.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/models/substance/interactions.dart';
import 'package:openjournal/models/substance/interaction_type.dart';
import 'dart:math';

void main() {
  group('NumberUtils tests', () {
    test('toReadableString rounds correctly', () {
      expect(123.456.toReadableString(), "123");
      expect(12.3456.toReadableString(), "12.3");
      expect(1.23456.toReadableString(), "1.23");
      expect(0.123456.toReadableString(), "0.12");
      expect(0.0123456.toReadableString(), "0.012");
    });
  });

  group('DateUtils tests', () {
    test('getDateWithWeekdayText format', () {
      final date = DateTime(2026, 7, 31);
      expect(DateUtilsOpenJournal.getDateWithWeekdayText(date), contains("Friday"));
      expect(DateUtilsOpenJournal.getDateWithWeekdayText(date), contains("31 Jul 2026"));
    });
  });

  group('Math logic parity tests', () {
    test('Gaussian error propagation (Uncertainty)', () {
      final sds = [10.0, 10.0, 10.0];
      final sumSq = sds.map((x) => x * x).reduce((a, b) => a + b);
      final result = sqrt(sumSq);
      expect(result, closeTo(17.32, 0.01));
    });
  });

  group('InteractionChecker tests', () {
    test('Detection of dangerous combination', () {
      final mdma = Substance(
        name: "MDMA",
        commonNames: [],
        url: "",
        isApproved: true,
        crossTolerances: [],
        toxicities: [],
        categories: ["stimulant", "empathogen"],
        saferUse: [],
        roas: [],
        interactions: Interactions(
          dangerous: ["MAOIs", "Tramadol"],
          unsafe: ["Alcohol"],
          uncertain: [],
        ),
      );

      final tramadol = Substance(
        name: "Tramadol",
        commonNames: [],
        url: "",
        isApproved: true,
        crossTolerances: [],
        toxicities: [],
        categories: ["opioid"],
        saferUse: [],
        roas: [],
      );

      final service = SubstanceService();
      service.substances = [mdma, tramadol];
      final checker = InteractionChecker(service);

      final result = checker.getInteractionBetween("MDMA", "Tramadol");

      expect(result, isNotNull);
      expect(result!.interactionType, InteractionType.dangerous);
    });
  });
}
