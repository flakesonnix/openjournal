import 'package:flutter/material.dart';
import 'package:openjournal/utils/url_launcher.dart';
import 'package:openjournal/theme/theme.dart';

class DrugTestingScreen extends StatelessWidget {
  const DrugTestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drug testing services')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _buildCountryCard(context, "Austria", [
            _ServiceItem("Drogenarbeit Z6", "Innsbruck", "https://www.drogenarbeitz6.at/drug-checking.html"),
            _ServiceItem("Checkit!", "Vienna", "https://checkit.wien/drug-checking-2/"),
            _ServiceItem("Triptalks", "Graz", "https://triptalks.at"),
          ]),
          _buildCountryCard(context, "Germany", [
            _ServiceItem("Drugchecking", "Berlin", "https://drugchecking.berlin"),
          ]),
          _buildCountryCard(context, "Switzerland", [
            _ServiceItem("DIZ / Saferparty", "Zurich", "https://en.saferparty.ch/angebote/drug-checking"),
            _ServiceItem("DIBS / Safer Dance Basel", "Basel", "https://de.saferdancebasel.ch/drugchecking"),
          ]),
          _buildCountryCard(context, "Spain", [
            _ServiceItem("Energy Control", "Various locations", "https://energycontrol.org/servicio-de-analisis/"),
          ]),
          // ... more can be added later
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => UrlLauncher.openUrl('https://t.me/openpsychonaut'),
            child: const Text('Report missing service', style: TextStyle(decoration: TextDecoration.underline)),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context, String title, List<_ServiceItem> services) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          const Divider(height: 1),
          ...services.map((s) => ListTile(
                leading: const Icon(Icons.biotech_outlined),
                title: Text(s.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                subtitle: Text(s.city, style: const TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.open_in_new, size: 16),
                onTap: () => UrlLauncher.openUrl(s.url),
              )),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final String name;
  final String city;
  final String url;
  _ServiceItem(this.name, this.city, this.url);
}
