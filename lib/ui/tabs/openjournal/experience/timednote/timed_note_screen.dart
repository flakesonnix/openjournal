import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/timednote/timed_note_state.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class TimedNoteScreen extends ConsumerWidget {
  final int? noteId;
  final int experienceId;

  const TimedNoteScreen({super.key, this.noteId, required this.experienceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = (noteId: noteId, experienceId: experienceId);
    final stateAsync = ref.watch(timedNoteProvider(arg));
    final notifier = ref.read(timedNoteProvider(arg).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: Text(noteId == null ? 'Add timed note' : 'Edit timed note'),
          actions: [
            if (noteId != null)
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
            TextField(
              controller: TextEditingController(text: state.note)
                ..selection = TextSelection.fromPosition(TextPosition(offset: state.note.length)),
              onChanged: notifier.updateNote,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(),
              ),
              autofocus: noteId == null,
            ),
            const SizedBox(height: 16),
            CardWithTitle(
              title: "Timeline",
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Show on timeline'),
                    value: state.isPartOfTimeline,
                    onChanged: notifier.updateIsPartOfTimeline,
                  ),
                  if (state.isPartOfTimeline) ...[
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Identity Color"),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: AdaptiveColor.values.where((c) => c.isPreferred).map((color) {
                        final isSelected = state.color == color;
                        return GestureDetector(
                          onTap: () => notifier.updateColor(color),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: color.getComposeColor(Theme.of(context).brightness == Brightness.dark),
                              shape: BoxShape.circle,
                              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
                              boxShadow: isSelected ? [BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
                            ),
                            child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            ListTile(
              title: const Text('Time'),
              subtitle: Text(DateFormat('EEEE, HH:mm').format(state.time)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(state.time),
                );
                if (picked != null) {
                  final now = DateTime.now();
                  notifier.updateTime(DateTime(now.year, now.month, now.day, picked.hour, picked.minute));
                }
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  void _confirmDelete(BuildContext context, TimedNoteNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note?'),
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
