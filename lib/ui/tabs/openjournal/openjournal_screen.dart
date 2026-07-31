import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/ui/tabs/openjournal/openjournal_state.dart';
import 'package:openjournal/ui/tabs/openjournal/components/experience_row.dart';
import 'package:openjournal/ui/tabs/openjournal/components/empty_screen_disclaimer.dart';
import 'package:openjournal/theme/theme.dart';

class OpenJournalScreen extends ConsumerWidget {
  const OpenJournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(openJournalProvider);
    final notifier = ref.read(openJournalProvider.notifier);

    return stateAsync.when(
      data: (state) => Scaffold(
        appBar: AppBar(
          title: state.isSearchEnabled
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search experiences...',
                    border: InputBorder.none,
                  ),
                  onChanged: notifier.setSearchText,
                  textInputAction: TextInputAction.search,
                )
              : const Text(
                  'OpenJournal',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
          actions: [
            IconButton(
              icon: Icon(state.isTimeRelativeToNow ? Icons.timer : Icons.timer_outlined),
              onPressed: () => notifier.setTimeRelativeToNow(!state.isTimeRelativeToNow),
              tooltip: 'Relative time',
            ),
            IconButton(
              icon: Icon(state.isFavoriteOnly ? Icons.star : Icons.star_outline),
              onPressed: () => notifier.setFavoriteOnly(!state.isFavoriteOnly),
              tooltip: 'Favorites only',
            ),
            IconButton(
              icon: Icon(state.isSearchEnabled ? Icons.search_off : Icons.search),
              onPressed: () => notifier.setSearchEnabled(!state.isSearchEnabled),
              tooltip: 'Search',
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                // TODO: Navigate to calendar
              },
              tooltip: 'Calendar',
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // Riverpod handles refresh by invalidating providers if needed
            return ref.refresh(openJournalProvider.future);
          },
          child: _buildList(state, notifier),
        ),
        floatingActionButton: !state.isSearchEnabled
            ? FloatingActionButton.extended(
                onPressed: () {
                  // TODO: Navigate to log dose
                },
                icon: const Icon(Icons.add),
                label: const Text('Log Dose'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              )
            : null,
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildList(OpenJournalState state, OpenJournalNotifier notifier) {
    if (state.activeExperiences.isEmpty && state.pastExperiences.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: EmptyScreenDisclaimer(
            title: state.isFavoriteOnly ? "No favorites" : "No experiences yet",
            description: state.isFavoriteOnly
                ? "Mark experiences as favorites to find them quickly."
                : "Add your first ingestion to start tracking.",
          ),
        ),
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        if (state.activeExperiences.isNotEmpty && !state.isSearchEnabled) ...[
          _buildHeader('Ongoing Sessions', OpenJournalColors.lightPrimary),
          ...state.activeExperiences.map((item) => ExperienceRow(
                item: item,
                onTap: () {
                  // TODO: Navigate to experience
                },
                isTimeRelativeToNow: state.isTimeRelativeToNow,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
            child: Divider(thickness: 0.5),
          ),
        ],
        if (state.pastExperiences.isNotEmpty || (state.isSearchEnabled && state.activeExperiences.isEmpty)) ...[
          if (!state.isSearchEnabled && state.activeExperiences.isNotEmpty)
            _buildHeader('History', OpenJournalColors.lightSecondary),
          ...state.pastExperiences.map((item) => ExperienceRow(
                item: item,
                onTap: () {
                  // TODO: Navigate to experience
                },
                isTimeRelativeToNow: state.isTimeRelativeToNow,
              )),
        ],
        const SizedBox(height: 80), // Space for FAB
      ],
    );
  }

  Widget _buildHeader(String text, Color color) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: horizontalPadding, top: 16, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

// Map standard hex colors to OpenJournalColors if needed, or use theme
class OpenJournalColors {
  static const lightPrimary = Color(0xFF405AA9);
  static const lightSecondary = Color(0xFF595E72);
}
