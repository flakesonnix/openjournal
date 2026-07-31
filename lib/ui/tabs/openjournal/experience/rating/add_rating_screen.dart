import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/models/experience/shulgin_rating_option.dart';
import 'package:openjournal/ui/tabs/openjournal/experience/rating/rating_state.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class AddRatingScreen extends ConsumerWidget {
  final int experienceId;

  const AddRatingScreen({super.key, required this.experienceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ratingProvider(experienceId));
    final notifier = ref.read(ratingProvider(experienceId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Intensity Rating')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...ShulginRatingOption.values.map((option) {
            final isSelected = state.selectedOption == option;
            return Card(
              color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
              child: ListTile(
                title: Text(option.sign, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text(option.shortDescription),
                onTap: () => notifier.setOption(option),
                trailing: isSelected ? const Icon(Icons.check) : null,
              ),
            );
          }),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Add timestamp'),
            subtitle: const Text('Records the specific time of this rating'),
            value: state.isTimed,
            onChanged: notifier.setIsTimed,
          ),
          if (state.isTimed)
            ListTile(
              title: const Text('Time'),
              subtitle: Text(DateFormat('HH:mm').format(state.time)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(state.time),
                );
                if (picked != null) {
                  final now = DateTime.now();
                  notifier.setTime(DateTime(now.year, now.month, now.day, picked.hour, picked.minute));
                }
              },
            ),
        ],
      ),
      floatingActionButton: state.selectedOption != null
          ? FloatingActionButton.extended(
              onPressed: () async {
                await notifier.save();
                if (context.mounted) context.pop();
              },
              icon: const Icon(Icons.done),
              label: const Text('Save Rating'),
            )
          : null,
    );
  }
}
