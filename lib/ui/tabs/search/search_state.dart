import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:rxdart/rxdart.dart';

class SearchState {
  final List<Substance> filteredSubstances;
  final List<CustomSubstance> filteredCustomSubstances;
  final List<String> categories;
  final String selectedCategory;
  final String searchText;
  final bool isLoading;

  SearchState({
    this.filteredSubstances = const [],
    this.filteredCustomSubstances = const [],
    this.categories = const [],
    this.selectedCategory = "All",
    this.searchText = "",
    this.isLoading = true,
  });

  SearchState copyWith({
    List<Substance>? filteredSubstances,
    List<CustomSubstance>? filteredCustomSubstances,
    List<String>? categories,
    String? selectedCategory,
    String? searchText,
    bool? isLoading,
  }) {
    return SearchState(
      filteredSubstances: filteredSubstances ?? this.filteredSubstances,
      filteredCustomSubstances: filteredCustomSubstances ?? this.filteredCustomSubstances,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchText: searchText ?? this.searchText,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SearchNotifier extends AutoDisposeAsyncNotifier<SearchState> {
  final _searchTextController = BehaviorSubject<String>.seeded("");
  final _categoryController = BehaviorSubject<String>.seeded("All");

  @override
  FutureOr<SearchState> build() async {
    final substanceService = ref.watch(substanceServiceProvider);
    final db = ref.watch(databaseProvider);

    // Get all categories from substances
    final allCategories = ["All"] + substanceService.substances
        .expand((s) => s.categories)
        .toSet()
        .toList()
      ..sort();

    final combinedStream = Rx.combineLatest3(
      _searchTextController.stream,
      _categoryController.stream,
      db.select(db.customSubstances).watch(),
      (String query, String category, List<CustomSubstance> customSubs) {

        final lowerQuery = query.toLowerCase();

        var filteredSubs = substanceService.substances;
        if (category != "All") {
          filteredSubs = filteredSubs.where((s) => s.categories.contains(category)).toList();
        }

        if (lowerQuery.isNotEmpty) {
          filteredSubs = filteredSubs.where((s) {
            return s.name.toLowerCase().contains(lowerQuery) ||
                s.commonNames.any((name) => name.toLowerCase().contains(lowerQuery));
          }).toList();
        }

        var filteredCustom = customSubs;
        if (lowerQuery.isNotEmpty) {
          filteredCustom = filteredCustom.where((s) => s.name.toLowerCase().contains(lowerQuery)).toList();
        }

        return SearchState(
          filteredSubstances: filteredSubs,
          filteredCustomSubstances: category == "All" ? filteredCustom : [],
          categories: allCategories,
          selectedCategory: category,
          searchText: query,
          isLoading: false,
        );
      },
    );

    ref.onDispose(() {
      _searchTextController.close();
      _categoryController.close();
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

  void setCategory(String category) {
    _categoryController.add(category);
  }
}

final searchProvider = AsyncNotifierProvider.autoDispose<SearchNotifier, SearchState>(() {
  return SearchNotifier();
});
