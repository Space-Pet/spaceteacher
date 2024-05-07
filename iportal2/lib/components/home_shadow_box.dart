import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class ShaDowBoxContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ShaDowBoxContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: AppRadius.rounded14,
        color: Colors.white,
        boxShadow: [homeBoxShadow()],
      ),
      child: child,
    );
  }
}

BoxShadow homeBoxShadow() {
  return const BoxShadow(
    color: Color.fromRGBO(46, 46, 79, 0.12),
    offset: Offset(0, 6),
    blurRadius: 20,
  );
}
