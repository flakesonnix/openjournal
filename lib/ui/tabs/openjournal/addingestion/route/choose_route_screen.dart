import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/services/substance_service.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'package:openjournal/theme/theme.dart';

class ChooseRouteScreen extends ConsumerWidget {
  final String substanceName;

  const ChooseRouteScreen({super.key, required this.substanceName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final substance = ref
        .watch(substanceServiceProvider)
        .substances
        .firstWhere((s) => s.name == substanceName);

    return Scaffold(
      appBar: AppBar(
        title: Text('$substanceName route'),
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(value: 0.5),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: substance.roas.length,
              itemBuilder: (context, index) {
                final roa = substance.roas[index];
                return InkWell(
                  onTap: () {
                    context.go('/add-ingestion/dose/$substanceName/${roa.route.name}');
                  },
                  child: Card(
                    color: roa.route.color.getComposeColor(Theme.of(context).brightness == Brightness.dark).withOpacity(0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            roa.route.displayText,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            roa.route.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
