import 'package:core/presentation/common_widget/filter_select.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class ScreenAppBarFilterClass extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final String? iconRight;
  final VoidCallback? onRight;
  final String? icon;
  final Widget? iconWidget;
  final int classSelect;
  final void Function(String) onChangeClassType;

  const ScreenAppBarFilterClass({
    super.key,
    this.onBack,
    this.iconWidget,
    this.icon,
    required this.title,
    this.classSelect = 1,
    this.onRight,
    this.iconRight,
    required this.onChangeClassType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 42, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (onBack != null) {
                onBack!();
              }
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 18,
                  color: AppColors.whiteBackground,
                ),
                const SizedBox(width: 8),
                Text(title,
                    style: AppTextStyles.semiBold18(color: AppColors.white)),
              ],
            ),
          ),
          FilterItem(
              isTransparentStyle: true,
              width: 160.h,
              title: 'Chọn lớp',
              options: const ['Lớp giảng dạy', 'Lớp chủ nhiệm'],
              selectedOption:
                  classSelect == 1 ? 'Lớp chủ nhiệm' : 'Lớp giảng dạy',
              onUpdateOption: (value) {
                onChangeClassType(value);
              }),
        ],
      ),
    );
  }
}
