import 'package:flutter/material.dart';
import 'package:openjournal/models/experience/experience_list_item.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/utils/date_utils.dart';

class ExperienceRow extends StatelessWidget {
  final ExperienceListItem item;
  final VoidCallback onTap;
  final bool isTimeRelativeToNow;

  const ExperienceRow({
    super.key,
    required this.item,
    required this.onTap,
    this.isTimeRelativeToNow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ColorRectangle(item: item),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.experience.title.isEmpty
                                  ? "Untitled Experience"
                                  : item.experience.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.experience.isFavorite)
                            Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.ingestions.isEmpty
                                  ? "No substance yet"
                                  : item.ingestions
                                      .map((i) => i.ingestion.substanceName)
                                      .toSet()
                                      .join(", "),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.rating != null)
                            Text(
                              item.rating!.sign,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isTimeRelativeToNow
                                ? DateUtilsOpenJournal.getRelativeTimeText(item.sortInstant)
                                : DateUtilsOpenJournal.getDateWithWeekdayText(item.sortInstant),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                                ),
                          ),
                          if (item.experience.locationName != null)
                            Text(
                              item.experience.locationName!,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                                  ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorRectangle extends StatelessWidget {
  final ExperienceListItem item;

  const ColorRectangle({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = item.ingestions
        .map((i) => i.substanceCompanion?.color.getComposeColor(isDark) ?? Colors.grey.withOpacity(0.1))
        .toList();

    return Container(
      width: 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: colors.length >= 2
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              )
            : null,
        color: colors.length == 1 ? colors.first : (colors.isEmpty ? Colors.grey.withOpacity(0.1) : null),
      ),
    );
  }
}
