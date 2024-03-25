import 'package:flutter/material.dart';
import 'package:utils/src/loading_indicator/loading_indicator.dart';

import 'buttons.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      this.fontSize = 14,
      this.textColor = Colors.blue,
      this.disableTextColor = Colors.grey,
      this.fontWeight = FontWeight.w600,
      this.onTap,
      this.status = ButtonStatus.enable,
      this.indicatorSize = 50,
      this.androidIndicatorColor = Colors.blue});

  final String text;
  final Color textColor;
  final Color disableTextColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onTap;
  final ButtonStatus status;
  final double indicatorSize;
  final Color androidIndicatorColor;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ButtonStatus.enable:
        return InkWell(
          onTap: onTap,
          child: Text(text,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor)),
        );

      case ButtonStatus.disabled:
        return Text(text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: disableTextColor));

      case ButtonStatus.loading:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: disableTextColor)),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: LoadingIndicator(
                size: indicatorSize,
                androidColor: androidIndicatorColor,
              ),
            )
          ],
        );

      default:
        return const SizedBox();
    }
  }
}
