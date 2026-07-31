import 'package:flutter/material.dart';
import 'package:openjournal/models/substance/roa_dose.dart';

class DoseClassificationRow extends StatelessWidget {
  final double? lightMin;
  final double? commonMin;
  final double? strongMin;
  final double? heavyMin;
  final String unit;

  const DoseClassificationRow({
    super.key,
    this.lightMin,
    this.commonMin,
    this.strongMin,
    this.heavyMin,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final threshColor = DoseClass.threshold.getColor(isDark);
    final lightColor = DoseClass.light.getColor(isDark);
    final commonColor = DoseClass.common.getColor(isDark);
    final strongColor = DoseClass.strong.getColor(isDark);
    final heavyColor = DoseClass.heavy.getColor(isDark);

    final labelStyle = Theme.of(context).textTheme.labelSmall;
    final numberStyle = Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildColumn(
            context,
            lightMin?.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '') ?? "..",
            "thresh",
            threshColor,
            lightColor,
            numberStyle,
            labelStyle,
          ),
          _buildSeparator("-", "light", lightColor, numberStyle, labelStyle),
          _buildColumnWithText(
            context,
            commonMin?.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '') ?? "..",
            lightColor,
            commonColor,
            numberStyle,
          ),
          _buildSeparator("-", "common", commonColor, numberStyle, labelStyle),
          _buildColumnWithText(
            context,
            strongMin?.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '') ?? "..",
            commonColor,
            strongColor,
            numberStyle,
          ),
          _buildSeparator("-", "strong", strongColor, numberStyle, labelStyle),
          _buildColumnWithText(
            context,
            heavyMin?.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '') ?? "..",
            strongColor,
            heavyColor,
            numberStyle,
          ),
          _buildSeparator("-", "heavy", heavyColor, numberStyle, labelStyle),
          Text(unit, style: numberStyle),
        ],
      ),
    );
  }

  Widget _buildColumn(
    BuildContext context,
    String value,
    String label,
    Color color1,
    Color color2,
    TextStyle? numberStyle,
    TextStyle? labelStyle,
  ) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(colors: [color1, color2]).createShader(bounds),
          child: Text(value, style: numberStyle?.copyWith(color: Colors.white)),
        ),
        Text(label, style: labelStyle),
      ],
    );
  }

  Widget _buildColumnWithText(
    BuildContext context,
    String value,
    Color color1,
    Color color2,
    TextStyle? numberStyle,
  ) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(colors: [color1, color2]).createShader(bounds),
      child: Text(value, style: numberStyle?.copyWith(color: Colors.white)),
    );
  }

  Widget _buildSeparator(String text, String label, Color color, TextStyle? numberStyle, TextStyle? labelStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(text, style: numberStyle?.copyWith(color: color)),
          Text(label, style: labelStyle?.copyWith(color: color)),
        ],
      ),
    );
  }
}
