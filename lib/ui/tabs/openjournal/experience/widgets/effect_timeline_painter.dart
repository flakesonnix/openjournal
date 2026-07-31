import 'package:flutter/material.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';
import 'package:openjournal/models/substance/roa_duration.dart';
import 'package:openjournal/models/substance/administration_route.dart';

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
      ..color = line.color.getComposeColor(isDarkTheme).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final startX = line.startTime.difference(startTime).inSeconds * pixelsPerSec;
    final path = Path();

    // Accurate duration values with defaults
    final onset = (line.roaDuration?.onset?.maxInSec ?? 1800.0);
    final comeup = (line.roaDuration?.comeup?.maxInSec ?? 3600.0);
    final peak = (line.roaDuration?.peak?.maxInSec ?? 7200.0);
    final offset = (line.roaDuration?.offset?.maxInSec ?? 7200.0);

    final h = chartHeight * line.height * 0.8; // Normalized height
    final yBase = chartHeight;
    final yPeak = chartHeight - h;

    path.moveTo(startX, yBase);

    // Onset (Flat at bottom)
    final onsetEnd = startX + onset;
    path.lineTo(onsetEnd, yBase);

    // Comeup (Smooth up to peak)
    final comeupEnd = onsetEnd + comeup;
    _startSmoothLineTo(path, 0.5, onsetEnd, yBase, comeupEnd, yPeak);

    // Peak (Flat at top)
    final peakEnd = comeupEnd + peak;
    path.lineTo(peakEnd, yPeak);

    // Offset (Smooth down to base)
    final offsetEnd = peakEnd + offset;
    _endSmoothLineTo(path, 0.5, peakEnd, offsetEnd, yBase);

    canvas.drawPath(path, paint);

    final strokePaint = Paint()
      ..color = line.color.getComposeColor(isDarkTheme)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(path, strokePaint);
  }

  void _startSmoothLineTo(Path path, double smoothness, double startX, double startY, double endX, double endY) {
    final diff = endX - startX;
    final controlX = startX + (diff * smoothness);
    path.quadraticBezierTo(controlX, startY, endX, endY);
  }

  void _endSmoothLineTo(Path path, double smoothness, double startX, double endX, double endY) {
    final diff = endX - startX;
    final controlX = endX - (diff * smoothness);
    path.quadraticBezierTo(controlX, endY, endX, endY);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
