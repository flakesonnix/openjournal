import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/edit/edit_experience_state.dart';
import 'package:go_router/go_router.dart';

class EditExperienceScreen extends ConsumerWidget {
  final int experienceId;

  const EditExperienceScreen({super.key, required this.experienceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(editExperienceProvider(experienceId));
    final notifier = ref.read(editExperienceProvider(experienceId).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit experience'),
          actions: [
            if (state.isTitleValid)
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () async {
                  await notifier.save();
                  if (context.mounted) context.pop();
                },
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: state.title)
                  ..selection = TextSelection.fromPosition(TextPosition(offset: state.title.length)),
                onChanged: notifier.updateTitle,
                decoration: InputDecoration(
                  labelText: 'Title',
                  errorText: state.isTitleValid ? null : 'Title cannot be empty',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: state.location)
                  ..selection = TextSelection.fromPosition(TextPosition(offset: state.location.length)),
                onChanged: notifier.updateLocation,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: state.notes)
                    ..selection = TextSelection.fromPosition(TextPosition(offset: state.notes.length)),
                  onChanged: notifier.updateNotes,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
