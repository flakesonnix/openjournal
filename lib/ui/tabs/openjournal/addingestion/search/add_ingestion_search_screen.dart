import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/add_ingestion_state.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/widgets/section_header.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/widgets/substance_row_add_ingestion.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/widgets/suggestion_row.dart';
import 'package:openjournal/theme/theme.dart';

class AddIngestionSearchScreen extends ConsumerWidget {
  const AddIngestionSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(addIngestionSearchProvider);
    final notifier = ref.read(addIngestionSearchProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ingestion'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SearchBar(
              hintText: 'Search substances',
              onChanged: notifier.updateSearchText,
              leading: const Icon(Icons.search),
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
            ),
          ),
        ),
      ),
      body: stateAsync.when(
        data: (state) => CustomScrollView(
          slivers: [
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.filteredSubstances.isEmpty &&
                state.filteredCustomSubstances.isEmpty &&
                state.filteredCustomUnits.isEmpty &&
                state.suggestions.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('No substances found')),
              )
            else ...[
              if (state.suggestions.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SectionHeader(title: 'Quick logging')),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final suggestion = state.suggestions[index];
                      return SuggestionRow(
                        suggestion: suggestion,
                        onOtherDose: (name, route) {
                          context.go('/add-ingestion/route/$name');
                        },
                        onCustomUnitOtherDose: (unitId) {
                          // TODO: Navigate to custom unit dose selection
                        },
                        onDoseSelected: (name, route, dose, units, isEst, sd, customUnitId) {
                          context.go('/add-ingestion/finish/$name/$route/$dose/${units ?? 'null'}/$isEst/${customUnitId ?? 'null'}');
                        },
                      );
                    },
                    childCount: state.suggestions.length,
                  ),
                ),
              ],
              if (state.filteredSubstances.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: SectionHeader(title: 'Substances'),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final substance = state.filteredSubstances[index];
                      return Column(
                        children: [
                          SubstanceRowAddIngestion(
                            name: substance.name,
                            commonNames: substance.commonNames,
                            onTap: () {
                              if (substance.hasInteractions) {
                                context.go('/add-ingestion/interactions/${substance.name}');
                              } else {
                                context.go('/add-ingestion/route/${substance.name}');
                              }
                            },
                          ),
                          if (index < state.filteredSubstances.length - 1)
                            const Divider(height: 1, indent: horizontalPadding, endIndent: horizontalPadding),
                        ],
                      );
                    },
                    childCount: state.filteredSubstances.length,
                  ),
                ),
              ],
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton.icon(
                    onPressed: () {
                      context.push('/add-custom-substance?name=${state.searchText}');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add custom substance'),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
