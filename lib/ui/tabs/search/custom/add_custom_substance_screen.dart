import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/search/custom/add_custom_substance_state.dart';
import 'package:go_router/go_router.dart';

class AddCustomSubstanceScreen extends ConsumerWidget {
  final String? initialName;

  const AddCustomSubstanceScreen({super.key, this.initialName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addCustomSubstanceProvider);
    final notifier = ref.read(addCustomSubstanceProvider.notifier);

    // If initialName is provided, update it once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialName != null && state.name.isEmpty) {
        notifier.updateName(initialName!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Substance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: notifier.updateName,
              controller: initialName != null ? TextEditingController(text: state.name) : null,
              decoration: const InputDecoration(
                labelText: 'Substance Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: notifier.updateUnits,
              decoration: const InputDecoration(
                labelText: 'Default Units (e.g. mg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: notifier.updateDescription,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: state.isValid
                    ? () => notifier.save((name) {
                          if (context.mounted) context.pop();
                        })
                    : null,
                child: const Text('Save Substance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
