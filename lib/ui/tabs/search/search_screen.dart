import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openjournal/ui/tabs/search/search_state.dart';
import 'package:openjournal/ui/tabs/search/widgets/substance_row.dart';
import 'package:openjournal/ui/tabs/openjournal/addingestion/search/widgets/section_header.dart';
import 'package:openjournal/theme/theme.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(searchProvider);
    final notifier = ref.read(searchProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Substances', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SearchBar(
                  hintText: 'Search substances...',
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
              stateAsync.when(
                data: (state) => SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      final isSelected = state.selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) => notifier.setCategory(category),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                loading: () => const SizedBox(height: 40),
                error: (_, __) => const SizedBox(height: 40),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: stateAsync.when(
        data: (state) => CustomScrollView(
          slivers: [
            if (state.filteredCustomSubstances.isNotEmpty) ...[
              const SliverToBoxAdapter(child: SectionHeader(title: 'Custom Substances')),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sub = state.filteredCustomSubstances[index];
                    return SubstanceRow(
                      name: sub.name,
                      commonNames: const [],
                      onTap: () {
                        // TODO: Navigate to custom substance detail
                      },
                    );
                  },
                  childCount: state.filteredCustomSubstances.length,
                ),
              ),
            ],
            if (state.filteredSubstances.isNotEmpty) ...[
              const SliverToBoxAdapter(child: SectionHeader(title: 'Substances')),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final sub = state.filteredSubstances[index];
                    return SubstanceRow(
                      name: sub.name,
                      commonNames: sub.commonNames,
                      onTap: () {
                        context.push('/substance/${sub.name}');
                      },
                    );
                  },
                  childCount: state.filteredSubstances.length,
                ),
              ),
            ],
            if (state.filteredSubstances.isEmpty && state.filteredCustomSubstances.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('No substances found')),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
