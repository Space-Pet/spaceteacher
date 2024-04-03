import 'package:flutter/material.dart';
import 'package:teacher/resources/resources.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.child,
    required this.buttonColor,
    this.borderRadius = 8,
    this.border,
    this.padding,
    this.margin,
    this.onTap,
    this.disabled = false,
  });

  final Widget child;
  final Color buttonColor;
  final BoxBorder? border;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        margin: margin ?? margin,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
        decoration: BoxDecoration(
          color: disabled ? AppColors.gray100 : buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
