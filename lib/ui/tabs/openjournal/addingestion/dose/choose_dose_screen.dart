import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseDoseScreen extends ConsumerWidget {
  final String substanceName;
  final String route;

  const ChooseDoseScreen({
    super.key,
    required this.substanceName,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$substanceName $route dose'),
      ),
      body: const Center(
        child: Text('Choose Dose Screen (Placeholder)'),
      ),
    );
  }
}
