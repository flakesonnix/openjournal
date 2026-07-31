import 'package:flutter/material.dart';
import 'package:openjournal/theme/theme.dart';

class PurityCalculationWidget extends StatelessWidget {
  final String purityText;
  final ValueChanged<String> onPurityChanged;
  final bool isValidPurity;
  final String? convertedDoseAndUnitText;

  const PurityCalculationWidget({
    super.key,
    required this.purityText,
    required this.onPurityChanged,
    required this.isValidPurity,
    this.convertedDoseAndUnitText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: TextEditingController(text: purityText)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: purityText.length),
            ),
          onChanged: onPurityChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Purity',
            suffixText: '%',
            errorText: isValidPurity ? null : 'Purity must be between 1 and 100%',
            border: const OutlineInputBorder(),
          ),
        ),
        if (convertedDoseAndUnitText != null) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Impure dose',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                convertedDoseAndUnitText!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
