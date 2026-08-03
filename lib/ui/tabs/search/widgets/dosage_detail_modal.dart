import 'package:flutter/material.dart';
import 'package:openjournal/models/substance/roa_dose.dart';
import 'package:openjournal/models/substance/roa.dart';
import 'package:openjournal/theme/theme.dart';

class DosageDetailModal extends StatelessWidget {
  final Roa roa;

  const DosageDetailModal({super.key, required this.roa});

  @override
  Widget build(BuildContext context) {
    final dose = roa.roaDose;
    if (dose == null) return const Center(child: Text("No dosage info available"));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            roa.route.displayText,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildRangeRow(context, "Threshold", dose.thresholdMin, dose.thresholdMax, DoseClass.threshold),
          _buildRangeRow(context, "Light", dose.lightMin, dose.lightMax, DoseClass.light),
          _buildRangeRow(context, "Common", dose.commonMin, dose.commonMax, DoseClass.common),
          _buildRangeRow(context, "Strong", dose.strongMin, dose.strongMax, DoseClass.strong),
          _buildRangeRow(context, "Heavy", dose.heavyMin, null, DoseClass.heavy),
          const SizedBox(height: 24),
          Text(
            "Units: ${dose.units}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildRangeRow(BuildContext context, String label, double? min, double? max, DoseClass doseClass) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String rangeText = "";
    if (min != null && max != null) {
      rangeText = "$min - $max";
    } else if (min != null) {
      rangeText = "$min+";
    } else {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: doseClass.getColor(isDark), fontWeight: FontWeight.bold)),
          Text(rangeText, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
