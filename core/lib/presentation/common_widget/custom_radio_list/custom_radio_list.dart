import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';
import 'custom_radio_list_controller.dart';

class CustomRadioList<T> extends StatefulWidget {
  final List<CustomRadioListItemData<T>> items;
  final EdgeInsetsGeometry? padding;
  final void Function(T) onSelected;
  final bool Function(T)? onChangeCondition;
  final CustomRadioListController<T, CustomRadioListItemData<T>> controller;

  CustomRadioList({
    Key? key,
    required this.items,
    this.padding,
    required this.onSelected,
    this.onChangeCondition,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomRadioList<T>> createState() => _CustomRadioListState<T>();
}

class _CustomRadioListState<T> extends State<CustomRadioList<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding ?? EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) => _buildRadioItem(
        widget.items.elementAt(index),
        theme,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      itemCount: widget.items.length,
    );
  }

  Widget _buildRadioItem(CustomRadioListItemData<T> item, ThemeData theme) {
    final _selectedItemNotifier = widget.controller;
    return ValueListenableBuilder(
      valueListenable: _selectedItemNotifier,
      builder: (context, value, _) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value == item
                ? themeColor.primaryColor
                : themeColor.colorE6E6EB,
            width: 1,
          ),
          color: value == item
              ? themeColor.primaryColor.withOpacity(0.05)
              : themeColor.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: RadioListTile<CustomRadioListItemData<T>>(
          title: Text(
            item.title ?? '',
            style: theme.textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          value: item,
          groupValue: widget.items
              .where((element) =>
                  element.title == _selectedItemNotifier.value?.title)
              .firstOrNull,
          onChanged: (value) {
            if (value?.item == null) {
              return;
            }

            if (widget.onChangeCondition != null &&
                widget.onChangeCondition!(value!.item!) != true) {
              return;
            }
            _selectedItemNotifier.value = value;

            widget.onSelected(value!.item!);
          },
          activeColor: themeColor.green,
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
        ),
      ),
    );
  }
}
