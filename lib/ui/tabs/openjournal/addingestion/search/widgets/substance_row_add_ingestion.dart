import 'package:flutter/material.dart';
import 'package:openjournal/theme/theme.dart';
import 'package:openjournal/models/substance/substance.dart';

class SubstanceRowAddIngestion extends StatelessWidget {
  final String name;
  final List<String> commonNames;
  final VoidCallback onTap;

  const SubstanceRowAddIngestion({
    super.key,
    required this.name,
    required this.commonNames,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (commonNames.isNotEmpty)
              Text(
                commonNames.join(", "),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
