import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';

part 'dropdown_controller.dart';

class DropdownWidget<T> extends StatelessWidget {
  final List<T> items;
  final Function(T?)? onChanged;
  final String? hint;
  final Widget Function(T) itemBuilder;
  final DropdownContoller<T, DropdownData<T>> controller;

  DropdownWidget({
    required this.controller,
    required this.itemBuilder,
    required this.items,
    this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ValueListenableBuilder<DropdownData<T>>(
      valueListenable: controller,
      builder: (ctx, value, w) {
        return DropdownButtonFormField<T>(
          value: value.value,
          items: items.map((e) {
            return DropdownMenuItem<T>(
              value: e,
              child: itemBuilder(e),
            );
          }).toList(),
          onChanged: (value) {
            controller.setData(value);
            onChanged?.call(value);
          },
          icon: Icon(
            Icons.expand_more,
            color: themeColor.greyE5,
            size: 14,
          ),
          iconSize: 16,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            hintText: hint,
            hintStyle: themeData.textTheme.titleSmall,
            errorText: value.validation,
            errorStyle: themeData.textTheme.titleMedium?.copyWith(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
