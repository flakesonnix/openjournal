import 'package:flutter/material.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/substance/roa_duration.dart';
import 'package:openjournal/models/substance/administration_route.dart';
import 'dart:math';

class TimelineLineData {
  final String substanceName;
  final AdministrationRoute route;
  final RoaDuration? roaDuration;
  final double height; // 0.0 to 1.0 (normalized)
  final double horizontalWeight; // 0.0 to 1.0
  final AdaptiveColor color;
  final DateTime startTime;
  final DateTime? endTime;

  TimelineLineData({
    required this.substanceName,
    required this.route,
    this.roaDuration,
    required this.height,
    required this.horizontalWeight,
    required this.color,
    required this.startTime,
    this.endTime,
  });
}

class EffectTimelinePainter extends CustomPainter {
  final List<TimelineLineData> dataForLines;
  final DateTime startTime;
  final double widthInSeconds;
  final bool isDarkTheme;

  EffectTimelinePainter({
    required this.dataForLines,
    required this.startTime,
    required this.widthInSeconds,
    required this.isDarkTheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (widthInSeconds <= 0) return;

    final pixelsPerSec = size.width / widthInSeconds;
    final chartHeight = size.height;

    for (var line in dataForLines) {
      _drawLine(canvas, line, pixelsPerSec, chartHeight);
    }
  }

  void _drawLine(Canvas canvas, TimelineLineData line, double pixelsPerSec, double chartHeight) {
    final paint = Paint()
      ..color = line.color.getComposeColor(isDarkTheme).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final startX = line.startTime.difference(startTime).inSeconds * pixelsPerSec;
    final path = Path();

    // Very simplified curve logic for now
    final onset = line.roaDuration?.onset?.maxInSec ?? 1800.0; // 30min default
    final comeup = line.roaDuration?.comeup?.maxInSec ?? 3600.0;
    final peak = line.roaDuration?.peak?.maxInSec ?? 7200.0;
    final offset = line.roaDuration?.offset?.maxInSec ?? 7200.0;

    final actualHeight = chartHeight * line.height * 0.8; // Leave some headroom

    path.moveTo(startX, chartHeight);

    // Onset + Comeup (Up)
    final peakStart = startX + onset + comeup;
    path.quadraticBezierTo(startX + onset, chartHeight, peakStart, chartHeight - actualHeight);

    // Peak (Flat)
    final peakEnd = peakStart + peak;
    path.lineTo(peakEnd, chartHeight - actualHeight);

    // Offset (Down)
    final totalEnd = peakEnd + offset;
    path.quadraticBezierTo(peakEnd + (offset * 0.5), chartHeight - actualHeight, totalEnd, chartHeight);

    path.close();
    canvas.drawPath(path, paint);

    // Stroke
    final strokePaint = Paint()
      ..color = line.color.getComposeColor(isDarkTheme)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
