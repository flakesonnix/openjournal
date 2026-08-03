import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/finish_ingestion_state.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/widgets/finish_ingestion_section.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:intl/intl.dart';

class FinishIngestionScreen extends ConsumerWidget {
  final String substanceName;
  final AdministrationRoute route;
  final double? dose;
  final String? units;
  final bool isEstimate;
  final double? estimatedDoseStandardDeviation;
  final int? customUnitId;
  final int? experienceId;

  const FinishIngestionScreen({
    super.key,
    required this.substanceName,
    required this.route,
    this.dose,
    this.units,
    required this.isEstimate,
    this.estimatedDoseStandardDeviation,
    this.customUnitId,
    this.experienceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = (
      substanceName: substanceName,
      route: route,
      dose: dose,
      units: units,
      isEstimate: isEstimate,
      estimatedDoseStandardDeviation: estimatedDoseStandardDeviation,
      customUnitId: customUnitId,
      experienceId: experienceId,
    );

    final stateAsync = ref.watch(finishIngestionProvider(arg));
    final notifier = ref.read(finishIngestionProvider(arg).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: Text(substanceName),
          centerTitle: false,
        ),
        bottomNavigationBar: _buildBottomBar(context, notifier),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const LinearProgressIndicator(value: 0.95),
            const SizedBox(height: 16),

            FinishIngestionSection(
              title: "Time",
              icon: Icons.timer_outlined,
              child: Column(
                children: [
                  SegmentedButton<IngestionTimePickerOption>(
                    segments: const [
                      ButtonSegment(value: IngestionTimePickerOption.pointInTime, label: Text('Point')),
                      ButtonSegment(value: IngestionTimePickerOption.timeRange, label: Text('Range')),
                    ],
                    selected: {state.timeOption},
                    onSelectionChanged: (set) => notifier.setTimeOption(set.first),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Time'),
                    subtitle: Text(DateFormat('EEEE, d MMM yyyy, HH:mm').format(state.startTime)),
                    trailing: const Icon(Icons.edit_calendar),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: state.startTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(const Duration(days: 1)),
                      );
                      if (picked != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(state.startTime),
                        );
                        if (time != null) {
                          notifier.updateStartTime(DateTime(
                            picked.year, picked.month, picked.day, time.hour, time.minute));
                        }
                      }
                    },
                  ),
                  if (state.timeOption == IngestionTimePickerOption.timeRange)
                    ListTile(
                      title: const Text('End Time'),
                      subtitle: Text(DateFormat('EEEE, d MMM yyyy, HH:mm').format(state.endTime)),
                      trailing: const Icon(Icons.edit_calendar),
                      onTap: () async {
                         final picked = await showDatePicker(
                          context: context,
                          initialDate: state.endTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now().add(const Duration(days: 1)),
                        );
                        if (picked != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(state.endTime),
                          );
                          if (time != null) {
                            notifier.updateEndTime(DateTime(
                              picked.year, picked.month, picked.day, time.hour, time.minute));
                          }
                        }
                      },
                    ),
                ],
              ),
            ),

            FinishIngestionSection(
              title: "Session",
              icon: Icons.book_outlined,
              child: Column(
                children: [
                  DropdownButtonFormField<int?>(
                    value: state.selectedExperience?.experience.id,
                    decoration: const InputDecoration(
                      labelText: 'Select Session',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Start new session')),
                      ...state.experiencesInRange.map((e) => DropdownMenuItem(
                        value: e.experience.id,
                        child: Text(e.experience.title, overflow: TextOverflow.ellipsis),
                      )),
                    ],
                    onChanged: (id) {
                      if (id == null) {
                        notifier.selectExperience(null);
                      } else {
                        notifier.selectExperience(state.experiencesInRange.firstWhere((e) => e.experience.id == id));
                      }
                    },
                  ),
                  if (state.selectedExperience == null) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: TextEditingController(text: state.enteredTitle)
                        ..selection = TextSelection.fromPosition(TextPosition(offset: state.enteredTitle.length)),
                      onChanged: notifier.updateTitle,
                      decoration: const InputDecoration(
                        labelText: 'Session Title',
                        hintText: 'e.g. Evening at home',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            FinishIngestionSection(
              title: "Notes",
              icon: Icons.notes,
              child: TextField(
                onChanged: notifier.updateNote,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            if (state.isShowingColorPicker)
              FinishIngestionSection(
                title: "Identity Color",
                icon: Icons.palette_outlined,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AdaptiveColor.values.where((c) => c.isPreferred).map((color) {
                    final isSelected = state.selectedColor == color;
                    return GestureDetector(
                      onTap: () => notifier.updateColor(color),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color.getComposeColor(Theme.of(context).brightness == Brightness.dark),
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                          boxShadow: isSelected ? [BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
                        ),
                        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                      ),
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildBottomBar(BuildContext context, FinishIngestionNotifier notifier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () async {
                final expId = await notifier.save();
                if (context.mounted) {
                  // Pre-fill next ingestion with the same session
                  context.go('/add-ingestion');
                  // We need a way to pass the expId to the next flow.
                  // For now, just go back to search.
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add another'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () async {
                await notifier.save();
                context.go('/');
              },
              icon: const Icon(Icons.done),
              label: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
