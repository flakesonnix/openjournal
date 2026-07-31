import 'package:flutter/material.dart';
import 'package:openjournal/models/substance/suggestion.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/utils/number_utils.dart';

class SuggestionRow extends StatelessWidget {
  final Suggestion suggestion;
  final Function(String, String) onOtherDose;
  final Function(String, String, double?, String?, bool, double?) onDoseSelected;

  const SuggestionRow({
    super.key,
    required this.suggestion,
    required this.onOtherDose,
    required this.onDoseSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestion is PureSubstanceSuggestion) {
      return _buildPureSuggestion(context, suggestion as PureSubstanceSuggestion);
    }
    // TODO: Add other suggestion types
    return const SizedBox.shrink();
  }

  Widget _buildPureSuggestion(BuildContext context, PureSubstanceSuggestion sugg) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ColorCircle(color: sugg.adaptiveColor.getComposeColor(isDark)),
              const SizedBox(width: 8),
              Text(
                '${sugg.substanceName} ${sugg.administrationRoute.displayText.toLowerCase()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...sugg.dosesAndUnit.map((d) => ActionChip(
                label: Text(_getDoseText(d)),
                onPressed: () => onDoseSelected(
                  sugg.substanceName,
                  sugg.administrationRoute.name,
                  d.dose,
                  d.unit,
                  d.isEstimate,
                  d.estimatedDoseStandardDeviation,
                ),
                labelStyle: const TextStyle(fontSize: 12),
              )),
              ActionChip(
                avatar: const Icon(Icons.keyboard, size: 16),
                label: const Text('Other dose'),
                onPressed: () => onOtherDose(sugg.substanceName, sugg.administrationRoute.name),
                labelStyle: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDoseText(DoseAndUnit d) {
    if (d.dose == null) return "Unknown";
    final val = d.dose!.toReadableString();
    if (d.isEstimate) {
      if (d.estimatedDoseStandardDeviation != null) {
        return "$val±${d.estimatedDoseStandardDeviation!.toReadableString()} ${d.unit}";
      }
      return "~$val ${d.unit}";
    }
    return "$val ${d.unit}";
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  const _ColorCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
