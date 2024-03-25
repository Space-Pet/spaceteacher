import 'package:flutter/material.dart';

import 'item_devider.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String? value;
  final Color color;
  final ItemDivider divider;
  final EdgeInsets padding;
  final Widget? myOwnValueWidget;
  final bool isBoldValue;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? titleTextTheme;
  final Color? dividerColor;

  const InfoItem({
    Key? key,
    required this.title,
    this.value,
    this.color = Colors.white,
    this.divider = ItemDivider.space,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.myOwnValueWidget,
    this.isBoldValue = false,
    this.crossAxisAlignment,
    this.titleTextTheme,
    this.dividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom:
            divider == ItemDivider.none || divider == ItemDivider.line ? 0 : 16,
      ),
      color: color,
      child: Padding(
        padding: EdgeInsets.only(left: padding.left, right: padding.right),
        child: Container(
          padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
          decoration: BoxDecoration(
            border: divider == ItemDivider.line
                ? Border(
                    bottom: BorderSide(
                      color: dividerColor ?? Colors.black12,
                      width: 1,
                    ),
                  )
                : null,
          ),
          child: Row(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleTextTheme ??
                    Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 8),
              myOwnValueWidget ??
                  Expanded(
                    child: Text(
                      value ?? '--',
                      style: isBoldValue
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
