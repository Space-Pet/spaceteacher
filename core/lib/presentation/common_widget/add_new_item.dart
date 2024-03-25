import 'package:flutter/material.dart';
import '../theme/theme_color.dart';

class AddNewItem extends StatelessWidget {
  AddNewItem({
    Key? key,
    required this.title,
    required this.onClicked,
    required this.themeColor,
  }) : super(key: key);

  final String title;
  final Function() onClicked;
  final ThemeColor themeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onClicked.call,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: themeColor.white,
          border: Border.all(
            color: themeColor.transparent,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: themeColor.primaryColor,
              size: 18,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: themeColor.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
