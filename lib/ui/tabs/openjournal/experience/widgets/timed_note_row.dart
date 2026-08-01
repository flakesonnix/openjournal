import 'package:flutter/material.dart';
import 'package:openjournal/services/database_service.dart';
import 'package:openjournal/models/experience/adaptive_color.dart';

class TimedNoteRow extends StatelessWidget {
  final TimedNote note;
  final Widget timeText;
  final VoidCallback onTap;

  const TimedNoteRow({
    super.key,
    required this.note,
    required this.timeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = AdaptiveColor.values.firstWhere((c) => c.name == note.color, orElse: () => AdaptiveColor.blue);

    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          children: [
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _DashedLine(
                color: note.isPartOfTimeline ? color.getComposeColor(isDark) : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        timeText,
                        if (!note.isPartOfTimeline) ...[
                          const SizedBox(width: 8),
                          Text(
                            "(Not in timeline)",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note.note,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  final Color? color;
  const _DashedLine({this.color});

  @override
  Widget build(BuildContext context) {
    if (color == null) return const SizedBox(width: 3);
    return CustomPaint(
      size: const Size(3, double.infinity),
      painter: _DashedLinePainter(color: color!),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    const dashHeight = 4.0;
    const dashSpace = 8.0;

    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
