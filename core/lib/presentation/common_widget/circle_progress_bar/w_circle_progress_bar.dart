import 'package:flutter/material.dart';
import 'circle_progress_bar_custompaint.dart';

class HalfCircularProgressBar extends StatefulWidget {
  final double value;
  final double strokeWidth;
  final Color fillColor;
  final Color backgroundColor;

  HalfCircularProgressBar(
      {required this.value,
      this.strokeWidth = 10.0,
      this.fillColor = Colors.blue,
      this.backgroundColor = Colors.grey});

  @override
  _HalfCircularProgressBarState createState() =>
      _HalfCircularProgressBarState();
}

class _HalfCircularProgressBarState extends State<HalfCircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation =
        Tween<double>(begin: 0.0, end: widget.value).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant HalfCircularProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.reset();
      _animation =
          Tween<double>(begin: 0.0, end: widget.value).animate(_controller);
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: CustomPaint(
                painter: CircularArchProgressBarPainter(
                  strokeWidth: widget.strokeWidth,
                  color: widget.backgroundColor,
                  value: 50,
                ),
              ),
            ),
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircularArchProgressBarPainter(
                      strokeWidth: widget.strokeWidth,
                      color: widget.fillColor,
                      value: _animation.value / 2,
                    ),
                  );
                },
              ),
            ),
            AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    '${_animation.value.toInt()}%',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
          ],
        ),
        const Text(
          'Trung bình',
          style: TextStyle(
            color: Color(0xFF667085),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
