import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class ReagentTestingScreen extends StatelessWidget {
  const ReagentTestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reagent testing'),
        actions: [
          TextButton(
            onPressed: () => launchUrl(Uri.parse('https://psychonautwiki.org/wiki/Reagent_testing_kits')),
            child: const Text('Article'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Reagent testing kits is a drug testing method that uses chemical solutions that change in color when applied to a chemical compound. They can help determine what chemical might be present in a given sample.\n\n"
                "Although very few substances are effective at dosages that allow the use of paper blotters, LSD is not the only one. Reagents can only determine the presence, not the quantity or purity.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          CardWithTitle(
            title: "Kit sellers",
            child: Column(
              children: [
                ListTile(
                  title: const Text('DanceSafe'),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () => launchUrl(Uri.parse('https://dancesafe.org/testing-kit-instructions/')),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Bunk Police'),
                  trailing: const Icon(Icons.open_in_new, size: 16),
                  onTap: () => launchUrl(Uri.parse('https://bunkpolice.com')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
