import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

class ExpandableContentItem {
  final int? index;
  final String? title;
  final String? content;

  ExpandableContentItem(
    this.title,
    this.content, {
    this.index,
  });
}

class ExpandableContent extends StatelessWidget {
  ExpandableContent({
    Key? key,
    required this.textTheme,
    required this.themeColor,
    required this.item,
  });

  final ExpandableController _expandableController = ExpandableController();
  final TextTheme textTheme;
  final ThemeColor themeColor;
  final ExpandableContentItem item;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _expandableController,
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: true,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToCollapse: false,
          useInkWell: false,
        ),
        collapsed: _buildHeader(),
        expanded: _buildBody(),
      ),
    );
  }

  InkWell _buildHeader() {
    return InkWell(
      onTap: _expandableController.toggle,
      child: Container(
        color: themeColor.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Expandable(
                collapsed: Text(
                  '''${item.index != null ? '${item.index ?? 0}. ' : ''}${item.title}''',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: themeColor.primaryText,
                  ),
                ),
                expanded: Text(
                  '''${item.index != null ? '${item.index ?? 0}. ' : ''}${item.title}''',
                  style: textTheme.bodyText2
                      ?.copyWith(fontSize: 14, color: themeColor.primaryColor),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expandable(
              collapsed: Icon(
                Icons.keyboard_arrow_down,
                color: themeColor.greyTextColor,
              ),
              expanded: Transform.rotate(
                angle: pi,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: themeColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        Text(
          item.content ?? '',
          style: textTheme.bodyText2?.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
