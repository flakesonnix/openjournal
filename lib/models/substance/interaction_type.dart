import 'package:flutter/material.dart';

enum InteractionType {
  dangerous(color: Color(0xFFFF7B66), dangerCount: 3),
  unsafe(color: Color(0xFFFFC466), dangerCount: 2),
  uncertain(color: Color(0xFFFFF966), dangerCount: 1);

  final Color color;
  final int dangerCount;

  const InteractionType({required this.color, required this.dangerCount});
}

class Interaction {
  final String aName;
  final String bName;
  final InteractionType interactionType;

  Interaction({
    required this.aName,
    required this.bName,
    required this.interactionType,
  });
}
