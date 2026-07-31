import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/experience_detail_item.dart';
import 'package:openjournal/services/openjournal_repository.dart';

class ExperienceDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<ExperienceDetailItem, int> {
  @override
  Future<ExperienceDetailItem> build(int experienceId) async {
    final repo = ref.watch(openJournalRepositoryProvider);
    final stream = repo.watchExperienceDetail(experienceId);

    final completer = Completer<ExperienceDetailItem>();
    late final StreamSubscription<ExperienceDetailItem> subscription;
    subscription = stream.listen(
      (item) {
        if (!completer.isCompleted) {
          completer.complete(item);
        }
        state = AsyncValue.data(item);
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
      },
    );
    ref.onDispose(() => unawaited(subscription.cancel()));

    return completer.future;
  }

  Future<void> toggleFavorite() async {
    final current = state.valueOrNull?.listItem.experience.isFavorite ?? false;
    final repo = ref.read(openJournalRepositoryProvider);
    await repo.setExperienceFavorite(arg, !current);
  }
}

final experienceDetailProvider = AsyncNotifierProvider.autoDispose
    .family<ExperienceDetailNotifier, ExperienceDetailItem, int>(
  ExperienceDetailNotifier.new,
);
