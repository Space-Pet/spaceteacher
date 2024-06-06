import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class TitleAndInputText extends StatelessWidget {
  const TitleAndInputText({
    super.key,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.title,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    this.onPressedIcon,
    this.textInputType = true,
    this.isRequired = true,
    this.isValid = true,
    this.titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
    this.focusNode,
    this.onSubmit,
    this.onTap,
    this.labelStyles,
    this.prefixIcon,
  });

  final String? title;
  final String hintText;
  final TextStyle? labelStyles;

  // prefix icon
  final Image? prefixIcon;

  final double paddingTop;
  final double paddingBottom;
  final bool isRequired;
  final bool textInputType;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Function()? onPressedIcon;
  final bool isValid;
  final TextStyle titleStyle;
  final FocusNode? focusNode;
  final Function()? onSubmit;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const redColor = AppColors.redMenu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if ((title ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              title ?? '',
              style: titleStyle,
            ),
          ),
        TextField(
          focusNode: focusNode,
          obscuringCharacter: '*',
          onChanged: onChanged,
          onTap: () {
            if (null != onTap) {
              onTap!();
            }
          },
          onSubmitted: (_) {
            if (null != onSubmit) {
              onSubmit!();
            }
          },
          cursorColor: isValid ? null : redColor,
          keyboardType:
              textInputType ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              maxHeight: 50,
              minHeight: 42,
            ),
            contentPadding: prefixIcon == null
                ? const EdgeInsets.symmetric(horizontal: 16)
                : EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: isValid ? AppColors.gray300 : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: isValid ? Colors.blue : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: isValid ? AppColors.gray300 : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: AppColors.gray500,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400),
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: isValid ? AppColors.gray500 : redColor,
            prefixIcon: prefixIcon,
          ),
          obscureText: obscureText,
        ),
      ],
    );
  }
}

class ChooseTypeButton extends StatelessWidget {
  const ChooseTypeButton({
    super.key,
    required this.label,
    required this.value,
    this.hintText = '',
    required this.isValid,
    this.onTap,
    this.borderRadius,
  });

  final String label;
  final String value;
  final String hintText;
  final bool isValid;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            '$label*',
            //style: AppTextStyles.textMedium,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 42,
              minHeight: 42,
            ),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(4),
                color: Colors.white,
                border: Border.all(
                    color: isValid ? Colors.grey : const Color(0xffCE2D30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value.isNotEmpty ? value : hintText,
                    style: TextStyle(
                      color: value.isNotEmpty
                          ? Colors.black
                          : Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
