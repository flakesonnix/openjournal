import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/experience_detail_state.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/widgets/experience_section.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/widgets/effect_timeline_painter.dart';
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
        if (state.experienceItem == null) {
          return const Scaffold(body: Center(child: Text("Experience not found")));
        }

        final exp = state.experienceItem!.experience;
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
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      context.push('/edit-experience/${exp.id}');
                    },
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  if (state.experienceItem!.ingestions.isNotEmpty)
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
                            dataForLines: state.experienceItem!.ingestions.map((i) {
                              // Dummy horizontal weight and height for now
                              return TimelineLineData(
                                substanceName: i.ingestion.substanceName,
                                route: AdministrationRoute.values.firstWhere((r) => r.name == i.ingestion.administrationRoute),
                                height: 0.5,
                                horizontalWeight: 1.0,
                                color: i.substanceCompanion?.color ?? AdaptiveColor.red,
                                startTime: i.ingestion.time,
                              );
                            }).toList(),
                            startTime: state.experienceItem!.sortInstant.subtract(const Duration(hours: 1)),
                            widthInSeconds: 3600 * 12, // 12 hours view
                            isDarkTheme: isDark,
                          ),
                        ),
                      ),
                    ),

                  ExperienceSection(
                    title: "Ingestions",
                    icon: Icons.medication,
                    child: Column(
                      children: state.experienceItem!.ingestions.map((i) => ListTile(
                        title: Text(i.ingestion.substanceName),
                        subtitle: Text("${i.ingestion.dose} ${i.ingestion.units}"),
                        trailing: Text(DateUtilsOpenJournal.getTimeText(i.ingestion.time)),
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
            onPressed: () {},
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
