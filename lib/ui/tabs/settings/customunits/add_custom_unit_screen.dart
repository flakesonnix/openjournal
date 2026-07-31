import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/settings/customunits/add_custom_unit_state.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:go_router/go_router.dart';

class AddCustomUnitScreen extends ConsumerWidget {
  final String substanceName;
  final String routeName;

  const AddCustomUnitScreen({super.key, required this.substanceName, required this.routeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arg = (substanceName: substanceName, routeName: routeName);
    final stateAsync = ref.watch(addCustomUnitProvider(arg));
    final notifier = ref.read(addCustomUnitProvider(arg).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(title: Text('$substanceName unit')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CardWithTitle(
              title: "Identity",
              child: Column(
                children: [
                  TextField(
                    onChanged: notifier.updateName,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'e.g. Blue rocket, 85% powder',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: notifier.updateUnit,
                    decoration: const InputDecoration(
                      labelText: 'Unit singular',
                      hintText: 'e.g. pill, capsule',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: notifier.updateUnitPlural,
                    controller: TextEditingController(text: state.unitPlural)
                      ..selection = TextSelection.fromPosition(TextPosition(offset: state.unitPlural.length)),
                    decoration: const InputDecoration(
                      labelText: 'Unit plural',
                      hintText: 'e.g. pills, capsules',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            CardWithTitle(
              title: "Conversion",
              child: Column(
                children: [
                  TextField(
                    onChanged: notifier.updateDose,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Dose per ${state.unit.isEmpty ? "unit" : state.unit}',
                      suffixText: state.originalUnit,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Switch(value: state.isEstimate, onChanged: notifier.updateIsEstimate),
                      const SizedBox(width: 8),
                      const Text("Estimate"),
                    ],
                  ),
                  if (state.isEstimate) ...[
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: notifier.updateEstimatedDeviation,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Estimated deviation',
                        suffixText: state.originalUnit,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CardWithTitle(
              title: "Details",
              child: Column(
                children: [
                  TextField(
                    onChanged: notifier.updateNote,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Note (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Archive'),
                    subtitle: const Text("Archived units don't show up when logging"),
                    value: state.isArchived,
                    onChanged: notifier.updateIsArchived,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
        floatingActionButton: state.isValid
            ? FloatingActionButton.extended(
                onPressed: () async {
                  await notifier.save();
                  if (context.mounted) context.pop();
                },
                icon: const Icon(Icons.done),
                label: const Text('Save Unit'),
              )
            : null,
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
