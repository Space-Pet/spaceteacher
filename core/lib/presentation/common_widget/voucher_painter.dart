import 'package:flutter/cupertino.dart';

class VoucherPainter extends CustomPainter {
  final Color color;
  final double curveSize;
  final double space;
  VoucherPainter({
    required this.color,
    this.curveSize = 5,
    this.space = 4,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    if (size.height < curveSize) {
      return;
    }
    final path = Path()..moveTo(0, 0);
    final step = curveSize + space;
    final count = size.height.let((h) {
      var count = 0;
      var start = 0.0;
      while (start < h - curveSize) {
        count++;
        start += curveSize;
        if (h - step > start) {
          start += space;
        } else {
          break;
        }
      }
      return count;
    });
    final offset =
        (size.height - (curveSize * count) - (space * (count - 1))) / 2;
    // Left
    var start = offset;
    path.lineTo(0, start);
    for (var i = 0; i < count; i++) {
      final endAct = Offset(
        0,
        start + curveSize,
      );
      start += curveSize;
      path.arcToPoint(
        endAct,
        radius: const Radius.circular(1),
      );
      if (i < count - 1) {
        path.lineTo(0, endAct.dy + space);
        start += space;
      }
    }
    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height);
    // Right
    start = size.height - offset;
    path.lineTo(size.width, start);
    for (var i = 0; i < count; i++) {
      start = start - curveSize;
      final endAct = Offset(
        size.width,
        start,
      );
      path.arcToPoint(
        endAct,
        radius: const Radius.circular(1),
      );
      if (i < count - 1) {
        path.lineTo(size.width, endAct.dy - space);
        start -= space;
      }
    }
    path
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);
}