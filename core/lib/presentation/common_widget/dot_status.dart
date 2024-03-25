import 'package:flutter/material.dart';

class DotStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: CustomPaint(
        painter: MakeCircle(),
      ),
    );
  }
}

class MakeCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.width / 2), 4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
