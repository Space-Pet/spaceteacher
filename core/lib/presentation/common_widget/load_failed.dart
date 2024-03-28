import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

class LoadFailed extends StatelessWidget {
  final Function()? onTap;

  const LoadFailed({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Failed to load. Tap to retry!',
            style: textTheme.titleMedium?.copyWith(
              color: themeColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
