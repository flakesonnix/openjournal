import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/interactions/check_interactions_state.dart';
import 'package:openjournal/models/substance/interaction_type.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/utils/url_launcher.dart';

class CheckInteractionsScreen extends ConsumerWidget {
  final String substanceName;
  final VoidCallback onNext;

  const CheckInteractionsScreen({
    super.key,
    required this.substanceName,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(checkInteractionsProvider(substanceName));
    final notifier = ref.read(checkInteractionsProvider(substanceName).notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(title: Text('$substanceName interactions')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: onNext,
          icon: const Icon(Icons.navigate_next),
          label: const Text('Next'),
        ),
        body: Column(
          children: [
            const LinearProgressIndicator(value: 0.33),
            if (state.isSearching)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (state.dangerousInteractions.isEmpty &&
                state.unsafeInteractions.isEmpty &&
                state.uncertainInteractions.isEmpty)
              const Expanded(
                child: Center(child: Text("No interactions found... check other sources.")),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    ...state.dangerousInteractions.map((i) => _buildRow(i, InteractionType.dangerous)),
                    ...state.unsafeInteractions.map((i) => _buildRow(i, InteractionType.unsafe)),
                    ...state.uncertainInteractions.map((i) => _buildRow(i, InteractionType.uncertain)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton.icon(
                        onPressed: () => UrlLauncher.openUrl(state.substance.url),
                        icon: const Icon(Icons.open_in_new),
                        label: const Text("View on PsychonautWiki"),
                      ),
                    ),
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

  Widget _buildRow(String text, InteractionType type) {
    return Container(
      color: type.color,
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          ...List.generate(
            type.dangerCount,
            (_) => const Icon(Icons.warning_amber_rounded, color: Colors.black54, size: 20),
          ),
        ],
      ),
    );
  }
}
