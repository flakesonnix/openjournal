import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/customunit/choose_dose_custom_unit_state.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/widgets/dose_classification_row.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/utils/number_utils.dart';

class ChooseDoseCustomUnitScreen extends ConsumerWidget {
  final int customUnitId;

  const ChooseDoseCustomUnitScreen({super.key, required this.customUnitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(chooseDoseCustomUnitProvider(customUnitId));
    final notifier = ref.read(chooseDoseCustomUnitProvider(customUnitId).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(title: Text(state.customUnit.name)),
        floatingActionButton: state.isValidDose
            ? FloatingActionButton.extended(
                onPressed: () {
                  final d = state.calculatedPureDose;
                  context.go(
                    '/add-ingestion/finish/${state.customUnit.substanceName}/${state.customUnit.administrationRoute}/$d/${state.customUnit.originalUnit}/${state.isEstimate}/$customUnitId',
                  );
                },
                icon: const Icon(Icons.navigate_next),
                label: const Text('Next'),
              )
            : null,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const LinearProgressIndicator(value: 0.67),
            const SizedBox(height: 16),
            CardWithTitle(
              title: "Substance Info",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.customUnit.substanceName} ${state.customUnit.administrationRoute}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (state.customUnit.note.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(state.customUnit.note),
                    ),
                  if (state.roaDose != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: DoseClassificationRow(
                        lightMin: state.roaDose!.lightMin,
                        commonMin: state.roaDose!.commonMin,
                        strongMin: state.roaDose!.strongMin,
                        heavyMin: state.roaDose!.heavyMin,
                        unit: state.roaDose!.units,
                      ),
                    ),
                  if (state.isValidDose)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        state.calculationText,
                        style: TextStyle(
                          color: state.currentDoseClass?.getColor(Theme.of(context).brightness == Brightness.dark),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            CardWithTitle(
              title: "Entry",
              child: Column(
                children: [
                  TextField(
                    onChanged: notifier.updateDose,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Dose',
                      suffixText: state.dose == 1.0 ? state.customUnit.unit : (state.customUnit.unitPlural ?? "${state.customUnit.unit}s"),
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
                      onChanged: notifier.updateDeviation,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Estimated deviation',
                        suffixText: state.customUnit.unit,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
