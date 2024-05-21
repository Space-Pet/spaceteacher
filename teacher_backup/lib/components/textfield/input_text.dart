import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TitleAndInputText extends StatefulWidget {
  const TitleAndInputText({
    Key? key,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    this.onPressedIcon,
    this.isRequired = true,
    this.isValid = true,
    this.titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    this.focusNode,
    this.onSubmit,
    this.onTap,
    this.labelStyles,
    this.prefixIcon,
    this.onEditComplated,
    this.prefixIconFallback = const SizedBox(),
    this.controller,
    this.onTapVisibilityPassword,
    this.isPasswordFeild = false,
    this.label,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final TextStyle? labelStyles;
  final Image? prefixIcon;
  final Widget prefixIconFallback;
  final double paddingTop;
  final double paddingBottom;
  final bool isRequired;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Function()? onPressedIcon;
  final bool isValid;
  final TextStyle titleStyle;
  final FocusNode? focusNode;
  final Function()? onSubmit;
  final Function()? onTap;
  final Function()? onTapVisibilityPassword;
  final Function()? onEditComplated;
  final TextEditingController? controller;
  final bool isPasswordFeild;
  final Widget? label;
  final TextInputType? keyboardType;
  @override
  _TitleAndInputTextState createState() => _TitleAndInputTextState();
}

class _TitleAndInputTextState extends State<TitleAndInputText> {
  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xffCE2D30);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
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
          onEditingComplete: () {
            if (null != widget.onEditComplated) {
              widget.onEditComplated!();
            }
          },
          cursorColor: widget.isValid ? null : redColor,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              maxHeight: 50,
              minHeight: 42,
            ),
            contentPadding: const EdgeInsets.all(5),
            label: widget.label,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: widget.isValid ? Colors.grey : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: widget.isValid ? Colors.blue : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: widget.isValid ? Colors.grey : redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.gray500),
            labelStyle: TextStyle(
              color: widget.isValid ? Colors.grey : redColor,
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: widget.isValid ? null : redColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPasswordFeild == true
                ? GestureDetector(
                    onTap: () {
                      widget.onTapVisibilityPassword?.call();
                    },
                    child: Icon(
                      widget.obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
        ),
      ],
    );
  }
}
