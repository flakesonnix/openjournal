import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:openjournal/ui/tabs/stats/stats_state.dart';
import 'dart:math';

class ActivityBarChart extends StatelessWidget {
  final List<List<ColorCount>> buckets;
  final String startDateText;

  const ActivityBarChart({
    super.key,
    required this.buckets,
    required this.startDateText,
  });

  @override
  Widget build(BuildContext context) {
    if (buckets.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxCount = buckets.map((b) => b.fold(0, (sum, c) => sum + c.count)).reduce(max).toDouble();
    final maxY = maxCount > 0 ? maxCount : 1.0;

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      if (value == 0) return const SizedBox.shrink();
                      if (value == maxY || value == maxY / 2) {
                        return Text(
                          value.toInt().toString(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.right,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: maxY / 2 > 0 ? maxY / 2 : 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: buckets.asMap().entries.map((entry) {
                final index = entry.key;
                final colorCounts = entry.value;

                double currentSum = 0;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: colorCounts.fold(0.0, (sum, c) => sum + c.count),
                      width: 8,
                      borderRadius: BorderRadius.circular(2),
                      rodStackItems: colorCounts.map((cc) {
                        final start = currentSum;
                        currentSum += cc.count;
                        return BarChartRodStackItem(start, currentSum, cc.color.getComposeColor(isDark));
                      }).toList(),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startDateText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            Text(
              "Now",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
