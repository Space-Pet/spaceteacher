import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CenterPositioned extends StatelessWidget {
  const CenterPositioned({
    super.key,
    required this.child,
    required this.top,
  });

  final double top;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: top.v,
      child: child,
    );
  }
}
