import 'package:flutter/material.dart';

import 'shadow.dart';
import 'theme_color.dart';

class ThemeButton {
  static TextStyle? getTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge;
  }

  static TextStyle? getTextStyleNormal(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: themeColor.primaryText,
        );
  }

  static Widget primary({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool enable = true,
    double radius = 5,
  }) =>
      RawMaterialButton(
        fillColor: enable
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withAlpha(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: enable ? onPressed : null,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)!.copyWith(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget primaryIcon({
    required BuildContext context,
    required String title,
    required Widget icon,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 15,
    ),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
  }) =>
      RawMaterialButton(
        fillColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: onPressed,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                title,
                style: getTextStyle(context)?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 6),
            icon,
          ],
        ),
      );

  static Widget notRecommend({
    required BuildContext context,
    String title = '',
    Function()? onPressed,
    double btnRadius = 5,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    TextStyle? textStyle,
    Color? fillColor,
    bool enable = true,
  }) =>
      RawMaterialButton(
        fillColor: fillColor ?? themeColor.grayAD,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius),
          side: BorderSide(
            color: themeColor.transparent,
            width: 1,
          ),
        ),
        onPressed: onPressed,
        elevation: 0,
        padding: padding,
        constraints: constraints,
        child: Text(
          title,
          style: textStyle ?? getTextStyle(context)?.copyWith(
            color: enable ? themeColor.white : themeColor.greyE5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );

  static Widget recommend({
    required BuildContext context,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 40.0),
    TextStyle? textStyle,
  }) {
    return ThemeButton.primary(
      context: context,
      title: title,
      onPressed: onPressed,
      padding: padding,
      constraints: constraints,
    );
  }

  static Widget bottomButton(
    BuildContext context, {
    String? title,
    String? content,
    String? description,
    String? buttonTitle,
    Function()? onTap,
    List<Widget>? buttons,
    bool isWithShadown = true,
    bool isPrimary = true,
    Widget? custom,
  }) {
    final theme = Theme.of(context);
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        boxShadow: isWithShadown ? boxShadowlight : null,
        color: themeColor.white,
      ),
      padding: const EdgeInsets.all(16).copyWith(
        bottom: paddingBottom < 16 ? 16 : paddingBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title?.isNotEmpty == true ||
              content?.isNotEmpty == true ||
              description?.isNotEmpty == true)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title?.isNotEmpty == true || content?.isNotEmpty == true)
                  Row(
                    children: [
                      if (title?.isNotEmpty == true)
                        Text(
                          title ?? '',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (content?.isNotEmpty == true)
                        Expanded(
                          child: Text(
                            content ?? '',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  ),
                if (description?.isNotEmpty == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '$description',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          buttons?.isNotEmpty == true
              ? Builder(builder: (context) {
                  final widgets = <Widget>[];
                  for (final button in buttons!) {
                    widgets.add(Expanded(child: button));
                    if (buttons.indexOf(button) != buttons.length - 1) {
                      widgets.add(const SizedBox(
                        width: 16,
                      ));
                    }
                  }
                  return Row(
                    children: widgets,
                  );
                })
              : isPrimary
                  ? ThemeButton.primary(
                      context: context,
                      title: buttonTitle ?? '',
                      onPressed: onTap,
                    )
                  : ThemeButton.notRecommend(
                      context: context,
                      title: buttonTitle ?? '',
                      onPressed: onTap,
                    ),
        ],
      ),
    );
  }

  static Widget deny({
    required BuildContext context,
    String title = '',
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16),
    BoxConstraints constraints = const BoxConstraints(minHeight: 48.0),
    bool? reverseColor,
  }) =>
      RawMaterialButton(
        fillColor: reverseColor == true ? Colors.red : const Color(0xffFFF0F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: onPressed,
        elevation: 0,
        constraints: constraints,
        child: Text(
          title,
          style: getTextStyle(context)!.copyWith(
            color: reverseColor == true ? themeColor.white : Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
