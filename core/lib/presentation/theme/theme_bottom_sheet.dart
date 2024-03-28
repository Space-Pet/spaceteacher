import 'package:flutter/material.dart';

class ThemeBottomSheet {
  static Widget bottomSheetForm(
    BuildContext context, {
    Widget? body,
    Function()? onTapClose,
    String title = '',
  }) {
    final themeData = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: themeData.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        title,
                        style: themeData.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onTapClose,
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body ?? const SizedBox()
          ],
        ),
      ),
    );
  }

  static Widget cupertinoBottomActionSheet({
    required BuildContext context,
    required Map<String, Function> action,
    Function()? onCancelPressed,
    String? title,
    required dynamic trans,
  }) {
    final theme = Theme.of(context);
    final BorderRadiusGeometry borderRadius = BorderRadius.circular(14);
    final padding = MediaQuery.of(context).padding;
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: padding.bottom + 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: const Color(0xF1EDEDED),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 22,
                    ),
                    child: Text(
                      title!,
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ...action.entries
                    .map<Widget>(
                      (e) => InkWell(
                        onTap: e.value.call(),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 18,
                          ),
                          child: Text(
                            e.key,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          const SizedBox(height: 8),
          RawMaterialButton(
            fillColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            onPressed: onCancelPressed,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                trans.cancel,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
