import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

enum TimePickerOption {
  days7('7D', 'Last week', 0, 7, Duration(days: 1), Duration(days: 7)),
  days30('30D', 'Last month', 1, 30, Duration(days: 1), Duration(days: 30)),
  weeks26('26W', 'Half year', 2, 26, Duration(days: 7), Duration(days: 7 * 26)),
  months12('12M', 'Last year', 3, 12, Duration(days: 30), Duration(days: 30 * 12)),
  years10('10Y', '10 years', 4, 10, Duration(days: 365), Duration(days: 365 * 10));

  final String displayText;
  final String longDisplayText;
  final int tabIndex;
  final int bucketCount;
  final Duration oneBucketSize;
  final Duration allBucketSizes;

  const TimePickerOption(this.displayText, this.longDisplayText, this.tabIndex,
      this.bucketCount, this.oneBucketSize, this.allBucketSizes);
}

class ColorCount {
  final AdaptiveColor color;
  final int count;
  ColorCount({required this.color, required this.count});
}

class RouteCount {
  final AdministrationRoute administrationRoute;
  final int count;
  RouteCount({required this.administrationRoute, required this.count});
}

class TotalDose {
  final double dose;
  final String units;
  final bool isEstimate;
  final double? estimatedDoseStandardDeviation;

  TotalDose({
    required this.dose,
    required this.units,
    required this.isEstimate,
    this.estimatedDoseStandardDeviation,
  });
}

class StatItem {
  final String substanceName;
  final AdaptiveColor color;
  final int experienceCount;
  final int ingestionCount;
  final List<RouteCount> routeCounts;
  final TotalDose? totalDose;

  StatItem({
    required this.substanceName,
    required this.color,
    required this.experienceCount,
    required this.ingestionCount,
    required this.routeCounts,
    this.totalDose,
  });
}

class StatsState {
  final TimePickerOption selectedOption;
  final bool areThereAnyIngestions;
  final String startDateText;
  final List<StatItem> statItems;
  final List<List<ColorCount>> chartBuckets;
  final String? consumerName;
  final List<String> availableConsumers;

  StatsState({
    required this.selectedOption,
    required this.areThereAnyIngestions,
    required this.startDateText,
    required this.statItems,
    required this.chartBuckets,
    this.consumerName,
    required this.availableConsumers,
  });
}

class StatsNotifier extends AutoDisposeAsyncNotifier<StatsState> {
  final _optionController = BehaviorSubject<TimePickerOption>.seeded(TimePickerOption.weeks26);
  final _consumerController = BehaviorSubject<String?>.seeded(null);

  @override
  FutureOr<StatsState> build() async {
    final repo = ref.watch(openJournalRepositoryProvider);

    final experiencesStream = repo.watchExperienceList();
    final consumersFuture = repo.getRecentConsumerNames();

    final combinedStream = Rx.combineLatest3(
      experiencesStream,
      _optionController.stream,
      _consumerController.stream,
      (List<ExperienceListItem> all, TimePickerOption option, String? consumer) {

        final now = DateTime.now();
        final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
        final startDate = endOfDay.subtract(option.allBucketSizes);

        final filteredByConsumer = all.where((e) {
          if (consumer == null) return e.ingestions.any((i) => i.ingestion.consumerName == null);
          return e.ingestions.any((i) => i.ingestion.consumerName == consumer);
        }).toList();

        final anyIngestions = filteredByConsumer.isNotEmpty;

        final relevant = filteredByConsumer.where((e) => e.sortInstant.isAfter(startDate)).toList();

        // Calculate chart buckets
        final buckets = <List<ColorCount>>[];
        var currentStart = endOfDay;
        for (var i = 0; i < option.bucketCount; i++) {
          final bucketEnd = currentStart;
          final bucketStart = currentStart.subtract(option.oneBucketSize);

          final experiencesInBucket = relevant.where((e) =>
            e.sortInstant.isAfter(bucketStart) && e.sortInstant.isBefore(bucketEnd) || e.sortInstant == bucketEnd
          ).toList();

          buckets.add(_getColorCounts(experiencesInBucket, consumer));
          currentStart = bucketStart;
        }

        // Calculate stat items
        final allIngestions = relevant.expand((e) => e.ingestions.where((i) => i.ingestion.consumerName == consumer)).toList();
        final groupedBySubstance = groupBy(allIngestions, (i) => i.ingestion.substanceName);

        final statItems = groupedBySubstance.entries.map((entry) {
          final name = entry.key;
          final ingests = entry.value;
          final color = ingests.first.substanceCompanion?.color ?? AdaptiveColor.grey;

          final expCount = relevant.where((e) => e.ingestions.any((i) => i.ingestion.substanceName == name)).length;

          final routeCounts = groupBy(ingests, (i) => i.ingestion.administrationRoute)
              .entries.map((re) => RouteCount(
                administrationRoute: AdministrationRoute.values.firstWhere((r) => r.name == re.key),
                count: re.value.length
              )).toList();

          return StatItem(
            substanceName: name,
            color: color,
            experienceCount: expCount,
            ingestionCount: ingests.length,
            routeCounts: routeCounts,
            totalDose: _getTotalDose(ingests),
          );
        }).toList()..sort((a, b) => b.experienceCount.compareTo(a.experienceCount));

        return StatsState(
          selectedOption: option,
          areThereAnyIngestions: anyIngestions,
          startDateText: DateFormat('EEE, dd MMM yyyy').format(startDate),
          statItems: statItems,
          chartBuckets: buckets.reversed.toList(),
          consumerName: consumer,
          availableConsumers: [], // Will be updated
        );
      }
    );

    final consumers = await consumersFuture;

    // Listen to updates
    combinedStream.listen((state) {
      this.state = AsyncValue.data(state.copyWith(availableConsumers: consumers));
    });

    final first = await combinedStream.first;
    return first.copyWith(availableConsumers: consumers);
  }

  List<ColorCount> _getColorCounts(List<ExperienceListItem> exps, String? consumer) {
    final substanceNames = exps.expand((e) =>
      e.ingestions.where((i) => i.ingestion.consumerName == consumer)
      .map((i) => i.ingestion.substanceName).toSet()
    ).toList();

    final counts = groupBy(substanceNames, (name) => name);

    return counts.entries.map((entry) {
      final name = entry.key;
      // Need a way to get color. We can find it from the ingestions.
      final color = exps.expand((e) => e.ingestions).firstWhere((i) => i.ingestion.substanceName == name).substanceCompanion?.color ?? AdaptiveColor.grey;
      return ColorCount(color: color, count: entry.value.length);
    }).toList()..sort((a, b) => b.count.compareTo(a.count));
  }

  TotalDose? _getTotalDose(List<IngestionWithCompanionAndCustomUnit> ingests) {
    if (ingests.isEmpty) return null;
    final firstUnit = ingests.first.ingestion.units;
    if (ingests.any((i) => i.ingestion.units != firstUnit || i.ingestion.dose == null)) return null;

    final sumDose = ingests.map((i) => i.ingestion.dose!).sum;
    final sumSD = ingests.map((i) => i.ingestion.estimatedDoseStandardDeviation ?? 0.0).sum;
    final isEst = ingests.any((i) => i.ingestion.isDoseAnEstimate);

    return TotalDose(
      dose: sumDose,
      units: firstUnit ?? "",
      isEstimate: isEst,
      estimatedDoseStandardDeviation: sumSD > 0 ? sumSD : null,
    );
  }

  void setOption(TimePickerOption option) {
    _optionController.add(option);
  }

  void setConsumer(String? consumer) {
    _consumerController.add(consumer);
  }
}

extension on StatsState {
  StatsState copyWith({
    TimePickerOption? selectedOption,
    bool? areThereAnyIngestions,
    String? startDateText,
    List<StatItem>? statItems,
    List<List<ColorCount>>? chartBuckets,
    String? consumerName,
    List<String>? availableConsumers,
  }) {
    return StatsState(
      selectedOption: selectedOption ?? this.selectedOption,
      areThereAnyIngestions: areThereAnyIngestions ?? this.areThereAnyIngestions,
      startDateText: startDateText ?? this.startDateText,
      statItems: statItems ?? this.statItems,
      chartBuckets: chartBuckets ?? this.chartBuckets,
      consumerName: consumerName ?? this.consumerName,
      availableConsumers: availableConsumers ?? this.availableConsumers,
    );
  }
}

final statsProvider = AsyncNotifierProvider.autoDispose<StatsNotifier, StatsState>(() {
  return StatsNotifier();
});
