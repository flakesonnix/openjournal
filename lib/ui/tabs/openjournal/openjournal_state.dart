import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:rxdart/rxdart.dart';

const int hourLimitToSeparateIngestions = 12;

class OpenJournalState {
  final List<ExperienceListItem> activeExperiences;
  final List<ExperienceListItem> pastExperiences;
  final bool isSearchEnabled;
  final String searchText;
  final bool isFavoriteOnly;
  final bool isTimeRelativeToNow;

  OpenJournalState({
    required this.activeExperiences,
    required this.pastExperiences,
    required this.isSearchEnabled,
    required this.searchText,
    required this.isFavoriteOnly,
    required this.isTimeRelativeToNow,
  });

  OpenJournalState copyWith({
    List<ExperienceListItem>? activeExperiences,
    List<ExperienceListItem>? pastExperiences,
    bool? isSearchEnabled,
    String? searchText,
    bool? isFavoriteOnly,
    bool? isTimeRelativeToNow,
  }) {
    return OpenJournalState(
      activeExperiences: activeExperiences ?? this.activeExperiences,
      pastExperiences: pastExperiences ?? this.pastExperiences,
      isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
      searchText: searchText ?? this.searchText,
      isFavoriteOnly: isFavoriteOnly ?? this.isFavoriteOnly,
      isTimeRelativeToNow: isTimeRelativeToNow ?? this.isTimeRelativeToNow,
    );
  }
}

class OpenJournalNotifier extends AutoDisposeAsyncNotifier<OpenJournalState> {
  final _searchTextController = StreamController<String>.broadcast();
  final _isFavoriteOnlyController = StreamController<bool>.broadcast();
  final _isTimeRelativeToNowController = StreamController<bool>.broadcast();
  final _isSearchEnabledController = StreamController<bool>.broadcast();

  String _searchText = "";
  bool _isFavoriteOnly = false;
  bool _isTimeRelativeToNow = false;
  bool _isSearchEnabled = false;

  @override
  FutureOr<OpenJournalState> build() async {
    final repo = ref.watch(openJournalRepositoryProvider);

    // We update the "now" every 30 seconds to refresh "ongoing sessions"
    final nowStream = Stream.periodic(const Duration(seconds: 30), (_) => DateTime.now())
        .startWith(DateTime.now());

    final combinedStream = Rx.combineLatest5(
      repo.watchExperienceList(),
      _searchTextController.stream.startWith(""),
      _isFavoriteOnlyController.stream.startWith(false),
      _isTimeRelativeToNowController.stream.startWith(false),
      nowStream,
      (List<ExperienceListItem> all, String search, bool fav, bool relative, DateTime now) {
        var filtered = all;

        if (fav) {
          filtered = filtered.where((e) => e.experience.isFavorite).toList();
        }

        if (search.isNotEmpty) {
          final query = search.toLowerCase();
          filtered = filtered.where((e) {
            final titleMatch = e.experience.title.toLowerCase().contains(query);
            final textMatch = e.experience.textContent.toLowerCase().contains(query);
            final substanceMatch = e.ingestions.any((i) =>
                i.ingestion.substanceName.toLowerCase().contains(query));
            final consumerMatch = e.ingestions.any((i) =>
                i.ingestion.consumerName?.toLowerCase().contains(query) ?? false);
            return titleMatch || textMatch || substanceMatch || consumerMatch;
          }).toList();
        }

        final active = filtered.where((e) {
          if (e.ingestions.isEmpty) return false;
          final lastIngestionTime = e.ingestions
              .map((i) => i.ingestion.time)
              .reduce((a, b) => a.isAfter(b) ? a : b);
          return lastIngestionTime.isAfter(now.subtract(const Duration(hours: hourLimitToSeparateIngestions)));
        }).toList();

        final past = filtered.where((e) => !active.contains(e)).toList();

        return OpenJournalState(
          activeExperiences: active,
          pastExperiences: past,
          isSearchEnabled: _isSearchEnabled,
          searchText: search,
          isFavoriteOnly: fav,
          isTimeRelativeToNow: relative,
        );
      },
    );

    ref.onDispose(() {
      _searchTextController.close();
      _isFavoriteOnlyController.close();
      _isTimeRelativeToNowController.close();
      _isSearchEnabledController.close();
    });

    final firstState = await combinedStream.first;

    // Listen to updates
    combinedStream.listen((state) {
      state = state.copyWith(isSearchEnabled: _isSearchEnabled);
      this.state = AsyncValue.data(state);
    });

    return firstState;
  }

  void setSearchText(String text) {
    _searchText = text;
    _searchTextController.add(text);
  }

  void setFavoriteOnly(bool value) {
    _isFavoriteOnly = value;
    _isFavoriteOnlyController.add(value);
  }

  void setTimeRelativeToNow(bool value) {
    _isTimeRelativeToNow = value;
    _isTimeRelativeToNowController.add(value);
  }

  void setSearchEnabled(bool value) {
    _isSearchEnabled = value;
    if (!value) {
      setSearchText("");
    }
    // Update local state immediately for UI responsiveness
    state.whenData((s) {
      state = AsyncValue.data(s.copyWith(isSearchEnabled: value, searchText: value ? _searchText : ""));
    });
  }
}

final openJournalProvider = AsyncNotifierProvider.autoDispose<OpenJournalNotifier, OpenJournalState>(() {
  return OpenJournalNotifier();
});
