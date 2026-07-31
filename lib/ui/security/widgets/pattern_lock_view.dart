import 'dart:math';
import 'package:flutter/material.dart';

class PatternLockView extends StatefulWidget {
  final Function(String) onPatternComplete;

  const PatternLockView({super.key, required this.onPatternComplete});

  @override
  State<PatternLockView> createState() => _PatternLockViewState();
}

class _PatternLockViewState extends State<PatternLockView> {
  final List<int> _points = [];
  Offset? _currentTouchPoint;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GestureDetector(
          onPanStart: (details) {
            setState(() {
              _points.clear();
              _currentTouchPoint = details.localPosition;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              _currentTouchPoint = details.localPosition;
              _checkPointHit(details.localPosition, context.size!);
            });
          },
          onPanEnd: (details) {
            if (_points.isNotEmpty) {
              widget.onPatternComplete(_points.join(','));
            }
            setState(() {
              _points.clear();
              _currentTouchPoint = null;
            });
          },
          child: CustomPaint(
            painter: _PatternPainter(
              points: _points,
              currentTouchPoint: _currentTouchPoint,
              primaryColor: Theme.of(context).colorScheme.primary,
              onSurfaceColor: Theme.of(context).colorScheme.onSurface,
            ),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  void _checkPointHit(Offset position, Size size) {
    final cellWidth = size.width / 3;
    final cellHeight = size.height / 3;
    final hitRadius = min(cellWidth, cellHeight) * 0.4;

    for (int i = 0; i < 9; i++) {
      final col = i % 3;
      final row = i ~/ 3;
      final center = Offset(
        col * cellWidth + cellWidth / 2,
        row * cellHeight + cellHeight / 2,
      );

      final distance = (position - center).distance;
      if (distance < hitRadius && !_points.contains(i)) {
        setState(() {
          _points.add(i);
        });
      }
    }
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> points;
  final Offset? currentTouchPoint;
  final Color primaryColor;
  final Color onSurfaceColor;

  _PatternPainter({
    required this.points,
    this.currentTouchPoint,
    required this.primaryColor,
    required this.onSurfaceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / 3;
    final cellHeight = size.height / 3;
    final dotRadius = min(cellWidth, cellHeight) * 0.15;

    final List<Offset> gridPoints = List.generate(9, (index) {
      final col = index % 3;
      final row = index ~/ 3;
      return Offset(
        col * cellWidth + cellWidth / 2,
        row * cellHeight + cellHeight / 2,
      );
    });

    final linePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw connections
    if (points.isNotEmpty) {
      final path = Path();
      path.moveTo(gridPoints[points.first].dx, gridPoints[points.first].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(gridPoints[points[i]].dx, gridPoints[points[i]].dy);
      }
      canvas.drawPath(path, linePaint);

      if (currentTouchPoint != null) {
        canvas.drawLine(gridPoints[points.last], currentTouchPoint!, linePaint);
      }
    }

    // Draw dots
    for (int i = 0; i < 9; i++) {
      final isSelected = points.contains(i);
      final dotPaint = Paint()
        ..color = isSelected ? primaryColor : onSurfaceColor.withOpacity(0.3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        gridPoints[i],
        isSelected ? dotRadius * 1.5 : dotRadius,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) => true;
}
