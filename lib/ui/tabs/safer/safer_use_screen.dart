import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class SaferUseScreen extends StatelessWidget {
  const SaferUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Harm Reduction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardWithTitle(
            title: "Basics",
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.science_outlined),
                  title: const Text('Reagent Testing'),
                  subtitle: const Text('Verify what you have'),
                  onTap: () {
                    context.push('/reagent-testing');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.water_drop_outlined),
                  title: const Text('Volumetric Dosing'),
                  subtitle: const Text('Precise liquid measurements'),
                  onTap: () {
                    context.push('/volumetric-dosing');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.biotech_outlined),
                  title: const Text('Drug Testing Services'),
                  subtitle: const Text('Find local checking services'),
                  onTap: () {
                    context.push('/drug-testing');
                  },
                ),
              ],
            ),
          ),
          CardWithTitle(
            title: "Guides by Class",
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.bolt),
                  title: const Text('Safer Stimulants'),
                  onTap: () {
                    context.push('/safer-stimulants');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.remove_red_eye_outlined),
                  title: const Text('Safer Hallucinogens'),
                  onTap: () {
                    context.push('/safer-hallucinogens');
                  },
                ),
              ],
            ),
          ),
          CardWithTitle(
            title: "ROA Safety",
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.air),
                  title: const Text('Safer Sniffing'),
                  onTap: () {
                    context.push('/safer-sniffing');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
