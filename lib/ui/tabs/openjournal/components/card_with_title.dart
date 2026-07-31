import 'package:flutter/material.dart';
import 'package:openjournal/theme/theme.dart';

class CardWithTitle extends StatelessWidget {
  final String title;
  final Widget child;
  final double innerPaddingHorizontal;

  const CardWithTitle({
    super.key,
    required this.title,
    required this.child,
    this.innerPaddingHorizontal = horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: verticalPaddingCards),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: innerPaddingHorizontal),
            child: child,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
