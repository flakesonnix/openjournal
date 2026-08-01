import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/substance/roa_dose.dart';
import 'package:openjournal/models/substance/roa_duration.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/models/experience/experience_detail_item.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class CumulativeRouteAndDose {
  final double cumulativeDose;
  final String units;
  final bool isEstimate;
  final double? cumulativeDoseStandardDeviation;
  final int? numDots;
  final AdministrationRoute route;
  final bool hasMoreThanOneIngestion;

  CumulativeRouteAndDose({
    required this.cumulativeDose,
    required this.units,
    required this.isEstimate,
    this.cumulativeDoseStandardDeviation,
    this.numDots,
    required this.route,
    required this.hasMoreThanOneIngestion,
  });
}

class CumulativeDose {
  final String substanceName;
  final List<CumulativeRouteAndDose> cumulativeRouteAndDose;

  CumulativeDose({
    required this.substanceName,
    required this.cumulativeRouteAndDose,
  });
}

class IngestionWithAssociatedData {
  final IngestionWithCompanionAndCustomUnit ingestionWithCompanion;
  final RoaDuration? roaDuration;
  final RoaDose? roaDose;

  IngestionWithAssociatedData({
    required this.ingestionWithCompanion,
    this.roaDuration,
    this.roaDose,
  });
}

class ExperienceDetailState {
  final ExperienceDetailItem? experienceDetail;
  final List<CumulativeDose> cumulativeDoses;
  final bool isCurrentExperience;
  final bool isLoading;

  ExperienceDetailState({
    this.experienceDetail,
    this.cumulativeDoses = const [],
    this.isCurrentExperience = false,
    this.isLoading = true,
  });

  ExperienceDetailState copyWith({
    ExperienceDetailItem? experienceDetail,
    List<CumulativeDose>? cumulativeDoses,
    bool? isCurrentExperience,
    bool? isLoading,
  }) {
    return ExperienceDetailState(
      experienceDetail: experienceDetail ?? this.experienceDetail,
      cumulativeDoses: cumulativeDoses ?? this.cumulativeDoses,
      isCurrentExperience: isCurrentExperience ?? this.isCurrentExperience,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ExperienceDetailNotifier extends AutoDisposeFamilyAsyncNotifier<ExperienceDetailState, int> {
  @override
  FutureOr<ExperienceDetailState> build(int experienceId) async {
    final repo = ref.watch(openJournalRepositoryProvider);
    final substanceService = ref.watch(substanceServiceProvider);

    final stream = repo.watchExperienceDetail(experienceId).map((detail) {
      final ingestionsWithData = detail.listItem.ingestions.map((i) {
        final substance = substanceService.substances.firstWhereOrNull((s) => s.name == i.ingestion.substanceName);
        final route = AdministrationRoute.values.firstWhereOrNull((r) => r.name == i.ingestion.administrationRoute);
        final roa = route != null ? substance?.getRoa(route) : null;
        return IngestionWithAssociatedData(
          ingestionWithCompanion: i,
          roaDuration: roa?.roaDuration,
          roaDose: roa?.roaDose,
        );
      }).toList();

      final cumulative = _calculateCumulativeDoses(ingestionsWithData);

      final now = DateTime.now();
      final lastTime = detail.listItem.ingestions.isEmpty
          ? null
          : detail.listItem.ingestions.map((i) => i.ingestion.time).reduce((a, b) => a.isAfter(b) ? a : b);
      final isCurrent = lastTime != null && lastTime.isAfter(now.subtract(const Duration(hours: 12)));

      return ExperienceDetailState(
        experienceDetail: detail,
        cumulativeDoses: cumulative,
        isCurrentExperience: isCurrent,
        isLoading: false,
      );
    });

    final first = await stream.first;

    stream.listen((s) {
      state = AsyncValue.data(s);
    });

    return first;
  }

  List<CumulativeDose> _calculateCumulativeDoses(List<IngestionWithAssociatedData> ingestions) {
    // Filter only my ingestions (consumerName == null)
    final myIngestions = ingestions.where((i) => i.ingestionWithCompanion.ingestion.consumerName == null).toList();

    final groupedByName = groupBy(myIngestions, (i) => i.ingestionWithCompanion.ingestion.substanceName);

    return groupedByName.entries.map((entry) {
      final name = entry.key;
      final substanceIngests = entry.value;

      final groupedByRoute = groupBy(substanceIngests, (i) => i.ingestionWithCompanion.ingestion.administrationRoute);

      final routes = groupedByRoute.entries.map((re) {
        final routeName = re.key;
        final routeIngests = re.value;

        final units = routeIngests.first.ingestionWithCompanion.ingestion.units;
        final sumDose = routeIngests.fold(0.0, (sum, i) => sum + (i.ingestionWithCompanion.ingestion.dose ?? 0.0));

        // Uncertainty propagation: sqrt(sum(sd^2))
        final sumSqSD = routeIngests.fold(0.0, (sum, i) {
          final sd = i.ingestionWithCompanion.ingestion.estimatedDoseStandardDeviation ?? 0.0;
          return sum + (sd * sd);
        });
        final totalSD = sqrt(sumSqSD);

        final isEst = routeIngests.any((i) => i.ingestionWithCompanion.ingestion.isDoseAnEstimate);
        final route = AdministrationRoute.values.firstWhere((r) => r.name == routeName);

        final numDots = routeIngests.first.roaDose?.getNumDots(sumDose, units);

        return CumulativeRouteAndDose(
          cumulativeDose: sumDose,
          units: units ?? "",
          isEstimate: isEst,
          cumulativeDoseStandardDeviation: totalSD > 0 ? totalSD : null,
          numDots: numDots,
          route: route,
          hasMoreThanOneIngestion: routeIngests.length > 1,
        );
      }).toList();

      return CumulativeDose(
        substanceName: name,
        cumulativeRouteAndDose: routes,
      );
    }).where((c) => c.cumulativeRouteAndDose.any((r) => r.hasMoreThanOneIngestion)).toList();
  }
}

final experienceDetailProvider = AsyncNotifierProvider.autoDispose.family<ExperienceDetailNotifier, ExperienceDetailState, int>(() {
  return ExperienceDetailNotifier();
});
