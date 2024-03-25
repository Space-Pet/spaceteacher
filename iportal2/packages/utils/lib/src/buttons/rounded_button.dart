import 'package:flutter/material.dart';
import 'package:utils/src/loading_indicator/loading_indicator.dart';
import 'package:utils/utils.dart';

class CenterIndicatorRoundedButton extends StatelessWidget {
  const CenterIndicatorRoundedButton(
      {super.key,
      this.backgroundColor = Colors.blue,
      this.disableBackgroundColor = Colors.grey,
      required this.child,
      this.borderRadius = 5,
      this.border,
      this.onTap,
      this.padding,
      this.status = ButtonStatus.enable,
      this.indicatorSize = 20,
      this.androidIndicatorColor = Colors.white});

  final VoidCallback? onTap;
  final Widget child;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final double borderRadius;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final ButtonStatus status;
  final double indicatorSize;
  final Color androidIndicatorColor;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ButtonStatus.enable:
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: border),
            child: Center(child: child),
          ),
        );
      case ButtonStatus.disabled:
        return Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: disableBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border),
          child: Center(child: child),
        );
      case ButtonStatus.loading:
        return Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: disableBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border),
          child: Center(
              child: LoadingIndicator(
            size: indicatorSize,
            androidColor: androidIndicatorColor,
          )),
        );
      default:
        return const SizedBox();
    }
  }
}

class EndIndicatorRoundedButton extends StatelessWidget {
  const EndIndicatorRoundedButton(
      {super.key,
      this.backgroundColor = Colors.blue,
      this.disableBackgroundColor = Colors.grey,
      required this.child,
      this.borderRadius = 5,
      this.border,
      this.onTap,
      this.padding,
      this.status = ButtonStatus.enable,
      this.indicatorSize = 20,
      this.androidIndicatorColor = Colors.white});

  final VoidCallback? onTap;
  final Widget child;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final double borderRadius;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final ButtonStatus status;
  final double indicatorSize;
  final Color androidIndicatorColor;
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ButtonStatus.enable:
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: border),
            child: Center(child: child),
          ),
        );
      case ButtonStatus.disabled:
        return Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: disableBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border),
          child: Center(child: child),
        );
      case ButtonStatus.loading:
        return Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: disableBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border),
          // child: Center(
          //     child: LoadingIndicator(
          //   size: indicatorSize,
          //   androidColor: androidIndicatorColor,
          // )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: indicatorSize,
                ),
                child,
                LoadingIndicator(
                  size: indicatorSize,
                  androidColor: androidIndicatorColor,
                )
              ],
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
