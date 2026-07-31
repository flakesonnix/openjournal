import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/substance/suggestion.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:rxdart/rxdart.dart';

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
  final _searchTextController = StreamController<String>.broadcast();

  @override
  FutureOr<AddIngestionSearchState> build() async {
    final substanceService = ref.watch(substanceServiceProvider);
    final repo = ref.watch(openJournalRepositoryProvider);
    final db = ref.watch(databaseProvider);

    // Initial search text
    _searchTextController.add("");

    final combinedStream = Rx.combineLatest4(
      _searchTextController.stream.startWith(""),
      Stream.fromFuture(db.select(db.customSubstances).get()), // In real app, might want to watch
      Stream.fromFuture(db.select(db.customUnits).get()),
      Stream.fromFuture(_getSuggestions()), // Simplified for now
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

        // Filter suggestions based on search
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

    return await combinedStream.first;
  }

  void updateSearchText(String text) {
    _searchTextController.add(text);
  }

  Future<List<Suggestion>> _getSuggestions() async {
    // TODO: Implement complex suggestion logic from Kotlin
    // For now returning empty list to avoid blocking UI build
    return [];
  }
}

final addIngestionSearchProvider = AsyncNotifierProvider.autoDispose<AddIngestionSearchNotifier, AddIngestionSearchState>(() {
  return AddIngestionSearchNotifier();
});
