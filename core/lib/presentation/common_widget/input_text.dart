import 'package:flutter/material.dart';

import '../../core.dart';
import '../../resources/app_colors.dart';

class TitleAndInputText extends StatefulWidget {
  TitleAndInputText({
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
    this.showIconEye = false,
    this.controller,
    this.minLines,
    this.isMultipleLines = false,
  });

  final String? title;
  final String hintText;
  final TextStyle? labelStyles;

  // prefix icon
  final Image? prefixIcon;
  final bool showIconEye;
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
  final TextEditingController? controller;
  final int? minLines;
  final bool isMultipleLines;

  @override
  State<TitleAndInputText> createState() => _TitleAndInputTextState();
}

class _TitleAndInputTextState extends State<TitleAndInputText> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    const redColor = AppColors.redMenu;
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((widget.title ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                widget.title ?? '',
                style: widget.titleStyle,
              ),
            ),
          TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscuringCharacter: '*',
            onChanged: widget.onChanged,
            onTap: () {
              if (null != widget.onTap) {
                widget.onTap!();
              }
            },
            onSubmitted: (_) {
              if (null != widget.onSubmit) {
                widget.onSubmit!();
              }
            },
            minLines: widget.minLines ?? 1,
            maxLines: widget.isMultipleLines ? (widget.minLines ?? 1) + 4 : 1,
            cursorColor: widget.isValid ? null : redColor,
            keyboardType: widget.textInputType
                ? TextInputType.text
                : TextInputType.number,
            decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxHeight: widget.isMultipleLines ? 100 : 44,
                  minHeight: 44,
                ),
                contentPadding: widget.prefixIcon == null
                    ? const EdgeInsets.symmetric(horizontal: 12, vertical: 4)
                    : EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.isValid ? AppColors.gray300 : redColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.isValid ? Colors.blue : redColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.isValid ? AppColors.gray300 : redColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: widget.hintText,
                hintStyle: AppTextStyles.normal14(),
                filled: true,
                fillColor: Colors.white,
                prefixIconColor: widget.isValid ? AppColors.gray500 : redColor,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.showIconEye
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.gray500,
                        ),
                      )
                    : null),
            obscureText: _obscureText,
          ),
        ],
      ),
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
