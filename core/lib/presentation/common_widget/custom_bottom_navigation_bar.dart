import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../theme/shadow.dart';
import '../theme/theme_color.dart';

class BottomBarItemData {
  final String lable;
  final Widget icon;
  final Widget selectedIcon;

  BottomBarItemData({
    required this.lable,
    required this.icon,
    required this.selectedIcon,
  });
}

class CustomBottomNavigationBar extends StatefulWidget {
  final Future<bool> Function(int) onItemSelection;
  final int selectedIdx;
  final List<BottomBarItemData> items;
  final bool isRounded;

  const CustomBottomNavigationBar({
    Key? key,
    required this.onItemSelection,
    this.selectedIdx = 0,
    required this.items,
    this.isRounded = false,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late ValueNotifier<int> idxNotifier;

  final itemPadding = 16.0;

  @override
  void initState() {
    idxNotifier = ValueNotifier(widget.selectedIdx);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    idxNotifier.value = widget.selectedIdx;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    idxNotifier = ValueNotifier(widget.selectedIdx);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    idxNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devicePaddingBottom = MediaQuery.of(context).padding.bottom;
    return ValueListenableBuilder<int>(
      valueListenable: idxNotifier,
      builder: (ctx, value, w) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: boxShadowlight,
            color: Colors.white,
            borderRadius: widget.isRounded
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                : null,
          ),
          padding: EdgeInsets.only(
            bottom: devicePaddingBottom < itemPadding
                ? itemPadding
                : devicePaddingBottom,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.items
                .mapIndex<Widget>(
                  (item, idx) => Expanded(
                    child: BottomItem(
                      item: item,
                      onPressed: () async {
                        if (idx != value &&
                            await widget.onItemSelection.call(idx) == true) {
                          idxNotifier.value = idx;
                        }
                      },
                      selected: idx == value,
                      padding: itemPadding,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class BottomItem extends StatelessWidget {
  final BottomBarItemData item;
  final Function()? onPressed;
  final bool selected;
  final double? padding;

  const BottomItem({
    Key? key,
    required this.item,
    this.onPressed,
    this.selected = false,
    this.padding = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: padding,
          ),
          SizedBox(width: 28, height: 28, child: _getIcon),
          const SizedBox(height: 4),
          if (item.lable.isNotEmpty)
            Text(
              item.lable,
              style: _getTextStyle(context),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget get _getIcon {
    if (selected) {
      return item.selectedIcon;
    } else {
      return item.icon;
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    if (selected) {
      return theme.textTheme.bodyLarge?.copyWith(
        fontSize: 12,
        color: themeColor.primaryColor,
      );
    } else {
      return theme.textTheme.titleSmall?.copyWith(
        fontSize: 12,
      );
    }
  }
}
