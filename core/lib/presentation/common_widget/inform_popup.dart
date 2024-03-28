import 'package:flutter/material.dart';

import '../theme/theme_button.dart';
import '../theme/theme_color.dart';

class InformationPopup extends StatelessWidget {
  final String content;
  final String title;
  final dynamic trans;

  const InformationPopup({
    Key? key,
    required this.content,
    required this.title,
    required this.trans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: themeColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          ThemeButton.primary(
            context: context,
            title: trans.close,
            onPressed: Navigator.of(context).pop,
          )
        ],
      ),
    );
  }
}
