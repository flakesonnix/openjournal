import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/substance/suggestion.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class AddIngestionSearchState {
  final List<Substance> filteredSubstances;
  final List<CustomSubstance> filteredCustomSubstances;
  final List<CustomUnit> filteredCustomUnits;
  final List<Suggestion> suggestions;
  final String searchText;
  final bool isLoading;

  AddIngestionSearchState({
    this.filteredSubstances = const [],
    this.filteredCustomSubstances = const [],
    this.filteredCustomUnits = const [],
    this.suggestions = const [],
    this.searchText = "",
    this.isLoading = true,
  });

  AddIngestionSearchState copyWith({
    List<Substance>? filteredSubstances,
    List<CustomSubstance>? filteredCustomSubstances,
    List<CustomUnit>? filteredCustomUnits,
    List<Suggestion>? suggestions,
    String? searchText,
    bool? isLoading,
  }) {
    return AddIngestionSearchState(
      filteredSubstances: filteredSubstances ?? this.filteredSubstances,
      filteredCustomSubstances: filteredCustomSubstances ?? this.filteredCustomSubstances,
      filteredCustomUnits: filteredCustomUnits ?? this.filteredCustomUnits,
      suggestions: suggestions ?? this.suggestions,
      searchText: searchText ?? this.searchText,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AddIngestionSearchNotifier extends AutoDisposeAsyncNotifier<AddIngestionSearchState> {
  final _searchTextController = BehaviorSubject<String>.seeded("");

  @override
  FutureOr<AddIngestionSearchState> build() async {
    final substanceService = ref.watch(substanceServiceProvider);
    final db = ref.watch(databaseProvider);

    final combinedStream = Rx.combineLatest4(
      _searchTextController.stream,
      db.select(db.customSubstances).watch(),
      db.select(db.customUnits).watch(),
      _getSuggestionsStream(),
      (String query, List<CustomSubstance> customSubs, List<CustomUnit> customUnits, List<Suggestion> suggs) {

        final lowerQuery = query.toLowerCase();

        final filteredSubs = query.isEmpty ? <Substance>[] : substanceService.substances.where((s) {
          return s.name.toLowerCase().contains(lowerQuery) ||
              s.commonNames.any((name) => name.toLowerCase().contains(lowerQuery));
        }).take(20).toList();

        final filteredCustomSubs = query.isEmpty ? <CustomSubstance>[] : customSubs.where((s) {
          return s.name.toLowerCase().contains(lowerQuery);
        }).toList();

        final filteredCustomUnits = query.isEmpty ? <CustomUnit>[] : customUnits.where((u) {
          return u.name.toLowerCase().contains(lowerQuery) ||
              u.unit.toLowerCase().contains(lowerQuery);
        }).toList();

        final filteredSuggs = suggs.where((s) {
          final matchedSubs = filteredSubs.map((sub) => sub.name).toList();
          return s.isInSearch(query, matchedSubs);
        }).toList();

        return AddIngestionSearchState(
          filteredSubstances: filteredSubs,
          filteredCustomSubstances: filteredCustomSubs,
          filteredCustomUnits: filteredCustomUnits,
          suggestions: filteredSuggs,
          searchText: query,
          isLoading: false,
        );
      },
    );

    ref.onDispose(() {
      _searchTextController.close();
    });

    final first = await combinedStream.first;

    combinedStream.listen((state) {
      this.state = AsyncValue.data(state);
    });

    return first;
  }

  void updateSearchText(String text) {
    _searchTextController.add(text);
  }

  Stream<List<Suggestion>> _getSuggestionsStream() {
    final db = ref.watch(databaseProvider);

    final query = db.select(db.ingestions).join([
      leftOuterJoin(db.substanceCompanions,
          db.substanceCompanions.substanceName.equalsExp(db.ingestions.substanceName)),
      leftOuterJoin(db.customUnits,
          db.customUnits.id.equalsExp(db.ingestions.customUnitId)),
    ])
    ..orderBy([OrderingTerm(expression: db.ingestions.time, mode: OrderingMode.desc)])
    ..limit(1000);

    return query.watch().map((rows) {
      final grouped = groupBy(rows, (row) => row.readTable(db.ingestions).substanceName);

      final results = <Suggestion>[];
      for (var entry in grouped.entries) {
        final substanceName = entry.key;
        final ingestionRows = entry.value;

        final color = ingestionRows.first.readTableOrNull(db.substanceCompanions)?.color ?? AdaptiveColor.grey;
        final latestTime = ingestionRows.first.readTable(db.ingestions).time;

        final routeGrouped = groupBy(ingestionRows, (row) => row.readTable(db.ingestions).administrationRoute);

        for (var routeEntry in routeGrouped.entries) {
          final routeName = routeEntry.key;
          final routeRows = routeEntry.value;
          final route = AdministrationRoute.values.firstWhere((r) => r.name == routeName);

          final doses = routeRows.map((r) {
            final ing = r.readTable(db.ingestions);
            return DoseAndUnit(
              dose: ing.dose,
              unit: ing.units ?? "",
              isEstimate: ing.isDoseAnEstimate,
              estimatedDoseStandardDeviation: ing.estimatedDoseStandardDeviation,
            );
          }).toSet().take(8).toList();

          results.add(PureSubstanceSuggestion(
            administrationRoute: route,
            substanceName: substanceName,
            adaptiveColor: color,
            dosesAndUnit: doses,
            sortInstant: latestTime,
          ));
        }
      }
      return results..sort((a, b) => b.sortInstant.compareTo(a.sortInstant));
    });
  }
}

final addIngestionSearchProvider = AsyncNotifierProvider.autoDispose<AddIngestionSearchNotifier, AddIngestionSearchState>(() {
  return AddIngestionSearchNotifier();
});
