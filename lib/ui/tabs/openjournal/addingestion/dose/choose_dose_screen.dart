import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/choose_dose_state.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/widgets/dose_classification_row.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/dose/widgets/purity_calculation_widget.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';
import 'package:openjournal/theme/theme.dart';

class ChooseDoseScreen extends ConsumerWidget {
  final String substanceName;
  final String route;

  const ChooseDoseScreen({
    super.key,
    required this.substanceName,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(chooseDoseProvider((substanceName: substanceName, routeName: route)));
    final notifier = ref.read(chooseDoseProvider((substanceName: substanceName, routeName: route)).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: Text('$substanceName ${state.route.displayText} dose'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            const LinearProgressIndicator(value: 0.67),
            const SizedBox(height: 12),
            CardWithTitle(
              title: "Dosage Info",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.roaDose != null)
                    DoseClassificationRow(
                      lightMin: state.roaDose!.lightMin,
                      commonMin: state.roaDose!.commonMin,
                      strongMin: state.roaDose!.strongMin,
                      heavyMin: state.roaDose!.heavyMin,
                      unit: state.roaDose!.units,
                    )
                  else
                    const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.orange),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "There is no dosage info for this administration route. Research dosages somewhere else.",
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            CardWithTitle(
              title: "Dose Entry",
              child: Column(
                children: [
                  if (state.currentDoseClass != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "Current: ${state.currentDoseClass!.name.toUpperCase()}",
                        style: TextStyle(
                          color: state.currentDoseClass!.getColor(Theme.of(context).brightness == Brightness.dark),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  TextField(
                    onChanged: notifier.updateDoseText,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Pure Dose',
                      suffixText: state.units,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Switch(
                        value: state.isEstimate,
                        onChanged: notifier.setEstimate,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Estimate",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  if (state.isEstimate) ...[
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: notifier.updateEstimatedDoseStandardDeviationText,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Estimated standard deviation',
                        suffixText: state.units,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (state.isValidDose)
              CardWithTitle(
                title: "Purity Calculation",
                child: PurityCalculationWidget(
                  purityText: state.purityText,
                  onPurityChanged: notifier.updatePurityText,
                  isValidPurity: state.isPurityValid,
                  convertedDoseAndUnitText: state.impureDoseWithUnit,
                ),
              ),
            CardWithTitle(
              title: "Units",
              child: Column(
                children: [
                  Text("Prefer to log with a different unit?"),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.push('/add-ingestion/add-custom-unit/$substanceName/$route');
                    },
                    child: const Text("Create a custom unit"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: state.isValidDose
            ? FloatingActionButton.extended(
                onPressed: () {
                  context.go(
                    '/add-ingestion/finish/${substanceName}/${route}/${state.dose}/${state.units.isEmpty ? 'null' : state.units}/${state.isEstimate}',
                  );
                },
                icon: const Icon(Icons.navigate_next),
                label: const Text('Next'),
              )
            : null,
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
