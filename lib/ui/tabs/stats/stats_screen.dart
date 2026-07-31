import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/stats/stats_state.dart';
import 'package:openjournal/ui/tabs/stats/widgets/activity_bar_chart.dart';
import 'package:openjournal/ui/tabs/stats/widgets/stat_item_card.dart';
import 'package:openjournal/ui/tabs/openjournal/components/empty_screen_disclaimer.dart';
import 'package:openjournal/utils/constants.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(statsProvider);
    final notifier = ref.read(statsProvider.notifier);

    return stateAsync.when(
      data: (state) => DefaultTabController(
        length: TimePickerOption.values.length,
        initialIndex: state.selectedOption.index,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usage Stats',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (state.consumerName != null)
                  Text(
                    'For: ${state.consumerName}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
              ],
            ),
            actions: [
              if (state.availableConsumers.isNotEmpty)
                PopupMenuButton<String?>(
                  icon: const Icon(Icons.person_outline),
                  onSelected: notifier.setConsumer,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: null,
                      child: Row(
                        children: [
                          if (state.consumerName == null) const Icon(Icons.check, size: 20),
                          const SizedBox(width: 8),
                          const Text(YOU),
                        ],
                      ),
                    ),
                    ...state.availableConsumers.map((name) => PopupMenuItem(
                          value: name,
                          child: Row(
                            children: [
                              if (state.consumerName == name) const Icon(Icons.check, size: 20),
                              const SizedBox(width: 8),
                              Text(name),
                            ],
                          ),
                        )),
                  ],
                ),
            ],
            bottom: TabBar(
              onTap: (index) => notifier.setOption(TimePickerOption.values[index]),
              isScrollable: true,
              tabs: TimePickerOption.values.map((o) => Tab(text: o.displayText)).toList(),
            ),
          ),
          body: !state.areThereAnyIngestions
              ? const Center(
                  child: EmptyScreenDisclaimer(
                    title: "No data to analyze",
                    description: "Log your first ingestion to see detailed usage statistics and charts.",
                  ),
                )
              : _buildList(context, state),
        ),
      ),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildList(BuildContext context, StatsState state) {
    if (state.statItems.isEmpty) {
      return const Center(
        child: EmptyScreenDisclaimer(
          title: "Quiet period",
          description: "No logs found for this time range. Try selecting a broader view.",
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.1)),
            ),
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timeline, color: Theme.of(context).colorScheme.primary, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        "Activity since ${state.startDateText}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ActivityBarChart(
                    buckets: state.chartBuckets,
                    startDateText: state.startDateText,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "Substance Breakdown",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...state.statItems.map((item) => StatItemCard(
              item: item,
              onTap: () {
                // TODO: Navigate to substance detail
              },
            )),
      ],
    );
  }
}
