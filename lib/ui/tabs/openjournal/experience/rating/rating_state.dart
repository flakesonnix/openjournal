import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:drift/drift.dart';

class RatingState {
  final ShulginRatingOption? selectedOption;
  final DateTime time;
  final bool isTimed;

  RatingState({
    this.selectedOption,
    required this.time,
    this.isTimed = false,
  });

  RatingState copyWith({
    ShulginRatingOption? selectedOption,
    DateTime? time,
    bool? isTimed,
  }) {
    return RatingState(
      selectedOption: selectedOption ?? this.selectedOption,
      time: time ?? this.time,
      isTimed: isTimed ?? this.isTimed,
    );
  }
}

class RatingNotifier extends AutoDisposeFamilyNotifier<RatingState, int> {
  @override
  RatingState build(int experienceId) => RatingState(time: DateTime.now());

  void setOption(ShulginRatingOption option) => state = state.copyWith(selectedOption: option);
  void setTime(DateTime time) => state = state.copyWith(time: time);
  void setIsTimed(bool val) => state = state.copyWith(isTimed: val);

  Future<void> save() async {
    final repo = ref.read(openJournalRepositoryProvider);
    final db = ref.read(databaseProvider);

    if (state.selectedOption != null) {
      await db.into(db.shulginRatings).insert(ShulginRatingsCompanion.insert(
        option: state.selectedOption!,
        time: Value(state.isTimed ? state.time : null),
        creationDate: Value(DateTime.now()),
        experienceId: arg,
      ));
    }
  }
}

final ratingProvider = NotifierProvider.autoDispose.family<RatingNotifier, RatingState, int>(() {
  return RatingNotifier();
});
