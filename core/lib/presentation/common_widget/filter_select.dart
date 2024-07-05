import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'select_flexible_bottom_sheet.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.title,
    required this.options,
    required this.onUpdateOption,
    this.selectedOption,
    this.width,
    this.hintText = 'Chọn',
    this.isTransparentStyle = false,
    this.isLoading = false,
    this.isFlexibleHeight = false,
  });

  final String title;
  final List<String> options;
  final String? selectedOption;
  final double? width;
  final String hintText;
  final void Function(String) onUpdateOption;
  final bool isTransparentStyle;
  final bool isLoading;
  final bool isFlexibleHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isFlexibleHeight && options.length > 5) {
          showFlexibleBottomSheet(
            minHeight: 0,
            initHeight: 0.8,
            maxHeight: 1,
            context: context,
            builder: (
              BuildContext context,
              ScrollController scrollController,
              double bottomSheetOffset,
            ) =>
                SelectFlexibleBottomSheet(
              scrollController: scrollController,
              title: title,
              options: options,
              selectedOption: selectedOption,
              onUpdateOption: onUpdateOption,
            ),
            anchors: [0, 1],
            isSafeArea: true,
            bottomSheetBorderRadius: AppRadius.roundedTop16,
          );
        } else {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) => SelectBottomSheet(
              title: title,
              options: options,
              selectedOption: selectedOption,
              onUpdateOption: onUpdateOption,
            ),
          );
        }
      },
      child: AppSkeleton(
        isLoading: isLoading,
        child: Container(
          padding: isTransparentStyle
              ? const EdgeInsets.fromLTRB(12, 2, 4, 2)
              : const EdgeInsets.fromLTRB(20, 4, 14, 4),
          decoration: BoxDecoration(
            color: isTransparentStyle ? Colors.transparent : AppColors.gray100,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color:
                  isTransparentStyle ? AppColors.gray100 : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedOption ?? hintText,
                  style: AppTextStyles.semiBold14(
                    color: isTransparentStyle
                        ? AppColors.white
                        : AppColors.brand600,
                  )),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isTransparentStyle ? AppColors.white : AppColors.gray400,
                size: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
