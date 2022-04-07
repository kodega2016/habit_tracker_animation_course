import 'dart:math';

import 'package:flutter/material.dart';

class RingPainer extends CustomPainter {
  final Color taskCompletedColor;
  final Color taskNotCompletedColor;
  final double progress;

  RingPainer({
    required this.progress,
    required this.taskCompletedColor,
    required this.taskNotCompletedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;

    if (notCompleted) {
      final backgroundPaint = Paint()
        ..color = taskNotCompletedColor
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    final foregroundPaint = Paint()
      ..color = taskCompletedColor
      ..isAntiAlias = true
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainer oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
