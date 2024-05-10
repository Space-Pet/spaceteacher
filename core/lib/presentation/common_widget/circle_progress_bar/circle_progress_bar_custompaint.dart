import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class CircularArchProgressBarPainter extends CustomPainter {
  final double strokeWidth;
  final double value;
  final Color color;

  CircularArchProgressBarPainter(
      {required this.strokeWidth, required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color

      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    const startAngle = math.pi / 1;
    final sweepAngle = 2 * math.pi * (value / 100);

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
