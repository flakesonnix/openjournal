import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:openjournal/ui/tabs/openjournal/calendar/calendar_state.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/services/openjournal_repository.dart';
import 'package:openjournal/ui/tabs/openjournal/components/experience_row.dart';
import 'package:go_router/go_router.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(calendarProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Calendar'),
        actions: [
          TextButton(
            onPressed: () => ref.read(calendarProvider.notifier).updateFocusedDay(DateTime.now()),
            child: const Text('Today'),
          ),
        ],
      ),
      body: stateAsync.when(
        data: (state) => Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: state.focusedDay,
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              headerStyle: const HeaderStyle(titleCentered: true),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) => _buildDay(context, day, state),
                todayBuilder: (context, day, focusedDay) => _buildDay(context, day, state, isToday: true),
                outsideBuilder: (context, day, focusedDay) => const SizedBox.shrink(),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                _showDayExperiences(context, ref, selectedDay);
              },
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildDay(BuildContext context, DateTime day, CalendarState state, {bool isToday = false}) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final colors = state.dayColors[normalizedDay] ?? [];

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? Theme.of(context).colorScheme.secondary.withOpacity(0.2) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              color: colors.isNotEmpty ? null : Colors.grey.withOpacity(0.5),
              fontWeight: isToday ? FontWeight.bold : null,
            ),
          ),
          if (colors.isNotEmpty)
            _HorizontalColorBar(colors: colors),
        ],
      ),
    );
  }

  void _showDayExperiences(BuildContext context, WidgetRef ref, DateTime day) async {
    final repo = ref.read(openJournalRepositoryProvider);
    final start = DateTime(day.year, day.month, day.day, 0, 0, 0);
    final end = DateTime(day.year, day.month, day.day, 23, 59, 59);

    final experiences = await repo.getExperiencesInRange(start, end);

    if (experiences.isEmpty) return;

    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        builder: (context) => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: experiences.length,
          itemBuilder: (context, index) => ExperienceRow(
            item: experiences[index],
            onTap: () {
              Navigator.pop(context);
              context.push('/experience/${experiences[index].experience.id}');
            },
            isTimeRelativeToNow: false,
          ),
        ),
      );
    }
  }
}

class _HorizontalColorBar extends StatelessWidget {
  final List<AdaptiveColor> colors;

  const _HorizontalColorBar({required this.colors});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 4,
      width: 20,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: colors.length >= 2
            ? LinearGradient(
                colors: colors.take(3).map((c) => c.getComposeColor(isDark)).toList(),
              )
            : null,
        color: colors.length == 1 ? colors.first.getComposeColor(isDark) : null,
      ),
    );
  }
}
