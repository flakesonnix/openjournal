import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:rxdart/rxdart.dart';

class CalendarState {
  final Map<DateTime, List<AdaptiveColor>> dayColors;
  final DateTime focusedDay;
  final bool isLoading;

  CalendarState({
    required this.dayColors,
    required this.focusedDay,
    this.isLoading = true,
  });

  CalendarState copyWith({
    Map<DateTime, List<AdaptiveColor>>? dayColors,
    DateTime? focusedDay,
    bool? isLoading,
  }) {
    return CalendarState(
      dayColors: dayColors ?? this.dayColors,
      focusedDay: focusedDay ?? this.focusedDay,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CalendarNotifier extends AutoDisposeAsyncNotifier<CalendarState> {
  @override
  FutureOr<CalendarState> build() async {
    final repo = ref.watch(openJournalRepositoryProvider);
    final now = DateTime.now();

    // Initial fetch for a wide range (e.g. current year +/- 1 year)
    final start = DateTime(now.year - 1, 1, 1);
    final end = DateTime(now.year + 1, 12, 31);

    final colors = await repo.getExperienceColorsByDay(start, end);

    return CalendarState(
      dayColors: colors,
      focusedDay: now,
      isLoading: false,
    );
  }

  void updateFocusedDay(DateTime day) {
    state.whenData((s) => state = AsyncValue.data(s.copyWith(focusedDay: day)));
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final repo = ref.read(openJournalRepositoryProvider);
    final now = DateTime.now();
    final start = DateTime(now.year - 1, 1, 1);
    final end = DateTime(now.year + 1, 12, 31);
    final colors = await repo.getExperienceColorsByDay(start, end);
    state = AsyncValue.data(CalendarState(dayColors: colors, focusedDay: now, isLoading: false));
  }
}

final calendarProvider = AsyncNotifierProvider.autoDispose<CalendarNotifier, CalendarState>(() {
  return CalendarNotifier();
});
