import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

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
    this.icon,
  });

  final Widget child;
  final Color buttonColor;
  final BoxBorder? border;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final bool disabled;
  final Widget? icon;

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: icon ?? Container(),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
