import 'package:flutter/material.dart';

import '../theme/theme_color.dart';
import 'item_devider.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final Widget icon;
  final Color? color;
  final ItemDivider? divider;
  final EdgeInsets padding;
  final Widget? tailIcon;

  const MenuItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
    this.divider,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.tailIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            divider == ItemDivider.none || divider == ItemDivider.line ? 0 : 16,
      ),
      child: Material(
        color: color ?? Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            child: Container(
              padding: EdgeInsets.only(
                top: padding.top,
                bottom: padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: divider == ItemDivider.line
                    ? Border(
                        bottom: BorderSide(
                          color: themeColor.lightGrey,
                          width: 0.5,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: themeColor.darkBlue,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  if (tailIcon != null) tailIcon!,
                  if (onTap != null && tailIcon == null)
                    const Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Colors.grey,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
