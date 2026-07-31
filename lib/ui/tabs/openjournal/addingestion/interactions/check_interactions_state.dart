import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/models/substance/interaction_type.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/interaction_checker.dart';
import 'package:openjournal/utils/date_utils.dart';
import 'package:openjournal/services/database_service.dart';

class CheckInteractionsState {
  final Substance substance;
  final List<String> dangerousInteractions;
  final List<String> unsafeInteractions;
  final List<String> uncertainInteractions;
  final bool isSearching;
  final bool isShowingAlert;
  final InteractionType? alertType;
  final String alertText;

  CheckInteractionsState({
    required this.substance,
    this.dangerousInteractions = const [],
    this.unsafeInteractions = const [],
    this.uncertainInteractions = const [],
    this.isSearching = true,
    this.isShowingAlert = false,
    this.alertType,
    this.alertText = "",
  });

  CheckInteractionsState copyWith({
    bool? isSearching,
    bool? isShowingAlert,
    InteractionType? alertType,
    String? alertText,
  }) {
    return CheckInteractionsState(
      substance: substance,
      dangerousInteractions: substance.interactions?.dangerous ?? [],
      unsafeInteractions: substance.interactions?.unsafe ?? [],
      uncertainInteractions: substance.interactions?.uncertain ?? [],
      isSearching: isSearching ?? this.isSearching,
      isShowingAlert: isShowingAlert ?? this.isShowingAlert,
      alertType: alertType ?? this.alertType,
      alertText: alertText ?? this.alertText,
    );
  }
}

class CheckInteractionsNotifier extends AutoDisposeFamilyAsyncNotifier<CheckInteractionsState, String> {
  @override
  FutureOr<CheckInteractionsState> build(String substanceName) async {
    final substanceService = ref.watch(substanceServiceProvider);
    final checker = ref.watch(interactionCheckerProvider);
    final db = ref.watch(databaseProvider);

    final substance = substanceService.substances.firstWhere((s) => s.name == substanceName);

    final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
    final latestIngestions = await (db.select(db.ingestions)
          ..where((t) => t.time.isBiggerThanValue(twoDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.time, mode: OrderingMode.desc)]))
        .get();

    final seen = <String>{};
    final uniqueLatest = latestIngestions.where((i) => seen.add(i.substanceName)).toList();

    List<String> messages = [];
    InteractionType? worstType;

    for (var ingestion in uniqueLatest) {
      final interaction = checker.getInteractionBetween(substanceName, ingestion.substanceName);
      if (interaction != null) {
        final type = interaction.interactionType;
        if (worstType == null || type.dangerCount > worstType.dangerCount) {
          worstType = type;
        }

        final timeAgo = DateUtilsOpenJournal.getRelativeTimeText(ingestion.time);
        final prefix = type == InteractionType.dangerous ? "Dangerous" : (type == InteractionType.unsafe ? "Unsafe" : "Uncertain");
        messages.add("$prefix interaction with ${ingestion.substanceName} (taken $timeAgo).");
      }
    }

    return CheckInteractionsState(
      substance: substance,
      isSearching: false,
      isShowingAlert: messages.isNotEmpty,
      alertType: worstType,
      alertText: messages.join("\n"),
    );
  }

  void dismissAlert() {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(isShowingAlert: false)));
  }
}

final checkInteractionsProvider = AsyncNotifierProvider.autoDispose.family<CheckInteractionsNotifier, CheckInteractionsState, String>(() {
  return CheckInteractionsNotifier();
});
