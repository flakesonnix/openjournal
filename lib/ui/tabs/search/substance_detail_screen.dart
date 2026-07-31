import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/models/substance/substance.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class SubstanceDetailScreen extends ConsumerWidget {
  final String substanceName;

  const SubstanceDetailScreen({super.key, required this.substanceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final substanceService = ref.watch(substanceServiceProvider);
    final substance = substanceService.substances.firstWhere((s) => s.name == substanceName);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(substance.name),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (substance.summary != null)
                CardWithTitle(
                  title: "Summary",
                  child: Text(substance.summary!),
                ),

              if (substance.effectsSummary != null)
                CardWithTitle(
                  title: "Effects",
                  child: Text(substance.effectsSummary!),
                ),

              CardWithTitle(
                title: "Dosages",
                child: Column(
                  children: substance.roas.map((roa) => ListTile(
                    title: Text(roa.route.displayText),
                    subtitle: Text(roa.roaDose?.units ?? ""),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Show dosage details
                    },
                  )).toList(),
                ),
              ),

              if (substance.tolerance != null)
                CardWithTitle(
                  title: "Tolerance",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (substance.tolerance?.full != null) Text("Full: ${substance.tolerance!.full}"),
                      if (substance.tolerance?.half != null) Text("Half: ${substance.tolerance!.half}"),
                      if (substance.tolerance?.zero != null) Text("Zero: ${substance.tolerance!.zero}"),
                    ],
                  ),
                ),

              if (substance.interactions != null)
                CardWithTitle(
                  title: "Safety Interactions",
                  child: Column(
                    children: [
                      ...substance.interactions!.dangerous.map((i) => ListTile(
                        leading: const Icon(Icons.warning, color: Colors.red),
                        title: Text(i),
                        subtitle: const Text("Dangerous"),
                      )),
                      ...substance.interactions!.unsafe.map((i) => ListTile(
                        leading: const Icon(Icons.warning, color: Colors.orange),
                        title: Text(i),
                        subtitle: const Text("Unsafe"),
                      )),
                    ],
                  ),
                ),

              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }
}
