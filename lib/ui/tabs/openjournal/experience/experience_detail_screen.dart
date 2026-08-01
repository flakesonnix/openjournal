import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/experience_detail_state.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/widgets/experience_section.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/widgets/effect_timeline_painter.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/widgets/timed_note_row.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/utils/date_utils.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:go_router/go_router.dart';

class ExperienceDetailScreen extends ConsumerWidget {
  final int experienceId;

  const ExperienceDetailScreen({super.key, required this.experienceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(experienceDetailProvider(experienceId));

    return stateAsync.when(
      data: (state) {
        if (state.experienceDetail == null) {
          return const Scaffold(body: Center(child: Text("Experience not found")));
        }

        final detail = state.experienceDetail!;
        final exp = detail.listItem.experience;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exp.title.isEmpty ? "Untitled Experience" : exp.title),
                    Text(
                      DateUtilsOpenJournal.getDateWithWeekdayText(exp.creationDate),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                actions: [
                  IconButton(icon: const Icon(Icons.timer_outlined), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.star_outline), onPressed: () {}),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'note', child: Text('Add Note')),
                      const PopupMenuItem(value: 'rating', child: Text('Add Rating')),
                      const PopupMenuItem(value: 'edit', child: Text('Edit Details')),
                    ],
                    onSelected: (val) {
                      if (val == 'edit') context.push('/edit-experience/${exp.id}');
                      if (val == 'rating') context.push('/add-rating/${exp.id}');
                      if (val == 'note') context.push('/add-timed-note/${exp.id}');
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  if (detail.listItem.ingestions.isNotEmpty)
                    ExperienceSection(
                      title: "Effect Timeline",
                      icon: Icons.timer_outlined,
                      headerAction: IconButton(
                        icon: const Icon(Icons.open_in_full),
                        onPressed: () {},
                      ),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomPaint(
                          painter: EffectTimelinePainter(
                            dataForLines: detail.listItem.ingestions.map((i) {
                              return TimelineLineData(
                                substanceName: i.ingestion.substanceName,
                                route: AdministrationRoute.values.firstWhere((r) => r.name == i.ingestion.administrationRoute),
                                height: 0.5,
                                horizontalWeight: 1.0,
                                color: i.substanceCompanion?.color ?? AdaptiveColor.red,
                                startTime: i.ingestion.time,
                              );
                            }).toList(),
                            startTime: detail.listItem.sortInstant.subtract(const Duration(hours: 1)),
                            widthInSeconds: 3600 * 12,
                            isDarkTheme: isDark,
                          ),
                        ),
                      ),
                    ),

                  ExperienceSection(
                    title: "Ingestions",
                    icon: Icons.medication,
                    child: Column(
                      children: detail.listItem.ingestions.map((i) => ListTile(
                        title: Text(i.ingestion.substanceName),
                        subtitle: Text("${i.ingestion.dose} ${i.ingestion.units}"),
                        trailing: Text(DateUtilsOpenJournal.getTimeText(i.ingestion.time)),
                        onTap: () {
                          context.push('/edit-ingestion/${i.ingestion.id}');
                        },
                      )).toList(),
                    ),
                  ),

                  if (detail.listItem.ratings.isNotEmpty)
                     ExperienceSection(
                      title: "Timeline Events",
                      icon: Icons.note_add_outlined,
                      child: Column(
                        children: detail.listItem.ratings.where((r) => r.time != null).map((r) => ListTile(
                          title: Text("Intensity: ${r.option.sign}"),
                          trailing: Text(DateUtilsOpenJournal.getTimeText(r.time!)),
                        )).toList(),
                      ),
                    ),

                  if (detail.timedNotes.isNotEmpty)
                    ExperienceSection(
                      title: "Timeline Notes",
                      icon: Icons.notes_outlined,
                      child: Column(
                        children: detail.timedNotes.map((note) => TimedNoteRow(
                          note: note,
                          timeText: Text(DateUtilsOpenJournal.getTimeText(note.time)),
                          onTap: () {
                            context.push('/edit-timed-note/${note.id}/${exp.id}');
                          },
                        )).toList(),
                      ),
                    ),

                  if (state.cumulativeDoses.isNotEmpty)
                    ExperienceSection(
                      title: "Cumulative Totals",
                      icon: Icons.auto_awesome,
                      child: Column(
                        children: state.cumulativeDoses.expand((c) => c.cumulativeRouteAndDose).map((r) => ListTile(
                          title: Text("${r.cumulativeDose} ${r.units}"),
                          subtitle: Text(r.route.displayText),
                        )).toList(),
                      ),
                    ),

                  if (exp.textContent.isNotEmpty)
                    ExperienceSection(
                      title: "Notes",
                      icon: Icons.notes,
                      child: Text(exp.textContent),
                    ),

                  const SizedBox(height: 100),
                ]),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
               context.go('/add-ingestion');
            },
            icon: const Icon(Icons.add),
            label: const Text("Log More"),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text("Error: $e"))),
    );
  }
}
