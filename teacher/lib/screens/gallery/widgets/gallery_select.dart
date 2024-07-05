import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GallerySelect extends StatelessWidget {
  final List<String> optionList;
  final String label;
  final String? selectedOption;
  final void Function(String) onUpdateOption;
  final bool isLoading;
  final bool isFlexibleHeight;
  final String title;

  const GallerySelect({
    super.key,
    required this.optionList,
    required this.label,
    required this.onUpdateOption,
    required this.title,
    this.selectedOption,
    this.isLoading = false,
    this.isFlexibleHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != '')
          Text(
            label,
            style: AppTextStyles.semiBold16(color: AppColors.gray700),
          ),
        const SizedBox(height: 4),
        FilterItem(
          title: title,
          options: optionList,
          selectedOption: selectedOption,
          onUpdateOption: (value) => onUpdateOption(value),
          isFlexibleHeight: isFlexibleHeight,
        ),
      ],
    );
  }
}
