import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/widgets/finish_ingestion_section.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/experience_detail_state.dart';
import 'package:openjournal/utils/date_utils.dart';

class ExperienceDetailScreen extends ConsumerWidget {
  final int experienceId;

  const ExperienceDetailScreen({super.key, required this.experienceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(experienceDetailProvider(experienceId));
    final notifier = ref.read(experienceDetailProvider(experienceId).notifier);

    return stateAsync.when(
      data: (detail) {
        final exp = detail.listItem.experience;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              exp.title.isEmpty ? 'Untitled Experience' : exp.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(
                  exp.isFavorite ? Icons.star : Icons.star_outline,
                  color: exp.isFavorite
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: notifier.toggleFavorite,
                tooltip: 'Favorite',
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 8),
              _buildHeader(context, detail.listItem),
              FinishIngestionSection(
                title: 'Substances',
                icon: Icons.science_outlined,
                child: detail.listItem.ingestions.isEmpty
                    ? const _EmptyText('No substances logged')
                    : Column(
                        children: detail.listItem.ingestions
                            .map((i) => _IngestionTile(item: i))
                            .toList(),
                      ),
              ),
              FinishIngestionSection(
                title: 'Timeline',
                icon: Icons.timeline,
                child: detail.timedNotes.isEmpty
                    ? const _EmptyText('No timeline notes')
                    : Column(
                        children: detail.timedNotes
                            .map((n) => _TimedNoteTile(note: n))
                            .toList(),
                      ),
              ),
              FinishIngestionSection(
                title: 'Rating',
                icon: Icons.star_outline,
                child: detail.listItem.ratings.isEmpty
                    ? const _EmptyText('No rating recorded')
                    : Column(
                        children: detail.listItem.ratings
                            .map((r) => _RatingTile(rating: r))
                            .toList(),
                      ),
              ),
              if (exp.textContent.isNotEmpty)
                FinishIngestionSection(
                  title: 'Report',
                  icon: Icons.notes,
                  child: Text(
                    exp.textContent,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ExperienceListItem item) {
    final exp = item.experience;
    return FinishIngestionSection(
      title: DateUtilsOpenJournal.getDateWithWeekdayText(exp.sortDate),
      icon: Icons.calendar_month,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (exp.locationName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    exp.locationName!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          if (item.rating != null)
            Text(
              '${item.rating!.sign} ${item.rating!.shortDescription}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
        ],
      ),
    );
  }
}

class _IngestionTile extends StatelessWidget {
  final IngestionWithCompanionAndCustomUnit item;

  const _IngestionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final ingestion = item.ingestion;
    final doseText = ingestion.dose != null
        ? '${_formatDose(ingestion.dose!)} ${ingestion.units ?? ''}'.trim()
        : 'Unknown dose';
    final route = AdministrationRoute.values
        .firstWhereOrNull((r) => r.name == ingestion.administrationRoute);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (item.substanceCompanion != null)
                Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: item.substanceCompanion!.color
                        .getComposeColor(Theme.of(context).brightness == Brightness.dark),
                    shape: BoxShape.circle,
                  ),
                ),
              Expanded(
                child: Text(
                  ingestion.substanceName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Text(
                DateUtilsOpenJournal.getTimeText(ingestion.time),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$doseText'
            '${ingestion.isDoseAnEstimate ? ' (estimate)' : ''}'
            ' · ${route?.displayText ?? ingestion.administrationRoute}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (ingestion.notes != null && ingestion.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                ingestion.notes!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          if (ingestion.endTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Ended at ${DateUtilsOpenJournal.getTimeText(ingestion.endTime!)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          const Divider(height: 16),
        ],
      ),
    );
  }
}

class _TimedNoteTile extends StatelessWidget {
  final TimedNote note;

  const _TimedNoteTile({required this.note});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 11,
            height: 11,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: BoxDecoration(
              color: note.color.getComposeColor(isDark),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateUtilsOpenJournal.getTimeText(note.time),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Text(note.note, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingTile extends StatelessWidget {
  final ShulginRating rating;

  const _RatingTile({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(
              rating.option.sign,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rating.time == null
                      ? 'Overall'
                      : DateUtilsOpenJournal.getTimeText(rating.time!),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  rating.option.shortDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  final String text;

  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

String _formatDose(double dose) {
  if (dose == dose.roundToDouble()) {
    return dose.toInt().toString();
  }
  return dose.toStringAsFixed(2);
}
