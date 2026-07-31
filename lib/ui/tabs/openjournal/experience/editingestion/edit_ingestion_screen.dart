import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/editingestion/edit_ingestion_state.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/time/finish_ingestion_state.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class EditIngestionScreen extends ConsumerWidget {
  final int ingestionId;

  const EditIngestionScreen({super.key, required this.ingestionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(editIngestionProvider(ingestionId));
    final notifier = ref.read(editIngestionProvider(ingestionId).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit ingestion'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context, notifier),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: state.isValid ? () async {
            await notifier.save();
            if (context.mounted) context.pop();
          } : null,
          icon: const Icon(Icons.done),
          label: const Text('Done'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CardWithTitle(
              title: "Dose",
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(text: state.doseText)
                      ..selection = TextSelection.fromPosition(TextPosition(offset: state.doseText.length)),
                    onChanged: notifier.updateDose,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Dose',
                      suffixText: state.ingestion.units,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Switch(value: state.isEstimate, onChanged: notifier.setEstimate),
                      const SizedBox(width: 8),
                      const Text("Estimate"),
                    ],
                  ),
                  if (state.isEstimate) ...[
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: notifier.updateSD,
                      decoration: const InputDecoration(
                        labelText: 'Estimated deviation',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CardWithTitle(
              title: "Time",
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
                  ListTile(
                    title: const Text('Start Time'),
                    subtitle: Text(DateFormat('HH:mm').format(state.startTime)),
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(state.startTime));
                      if (time != null) {
                        notifier.updateStartTime(DateTime(state.startTime.year, state.startTime.month, state.startTime.day, time.hour, time.minute));
                      }
                    },
                  ),
                ],
              ),
            ),
            CardWithTitle(
              title: "Notes",
              child: TextField(
                onChanged: notifier.updateNotes,
                controller: TextEditingController(text: state.notes)
                  ..selection = TextSelection.fromPosition(TextPosition(offset: state.notes.length)),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  void _confirmDelete(BuildContext context, EditIngestionNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete ingestion?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () async {
            await notifier.delete();
            if (context.mounted) {
              Navigator.pop(context);
              GoRouter.of(context).pop();
            }
          }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
