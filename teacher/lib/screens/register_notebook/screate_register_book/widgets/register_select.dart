import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RegisterSelect extends StatelessWidget {
  const RegisterSelect({
    super.key,
    required this.title,
    required this.options,
    required this.onUpdateOption,
    this.selectedOption,
    this.width,
    this.hintText = 'Chọn',
    this.isTransparentStyle = false,
    this.isLoading = false,
  });

  final String title;
  final List<String> options;
  final String? selectedOption;
  final double? width;
  final String hintText;
  final void Function(String) onUpdateOption;
  final bool isTransparentStyle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
      },
      child: AppSkeleton(
        isLoading: isLoading,
        child: Container(
          width: width ?? double.infinity,
          padding: isTransparentStyle
              ? const EdgeInsets.fromLTRB(12, 2, 4, 2)
              : const EdgeInsets.fromLTRB(20, 4, 14, 4),
          decoration: BoxDecoration(
            color: isTransparentStyle ? Colors.transparent : AppColors.white,
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
