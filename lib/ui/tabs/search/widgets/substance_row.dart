import 'package:flutter/material.dart';
import 'package:openjournal/theme/theme.dart';

class SubstanceRow extends StatelessWidget {
  final String name;
  final List<String> commonNames;
  final VoidCallback onTap;

  const SubstanceRow({
    super.key,
    required this.name,
    required this.commonNames,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: commonNames.isNotEmpty
          ? Text(
              commonNames.join(", "),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          : null,
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
