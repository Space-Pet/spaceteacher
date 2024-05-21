import 'package:flutter/material.dart';
import 'package:core/resources/app_colors.dart';

class TitleAndInputText extends StatefulWidget {
  const TitleAndInputText({
    super.key,
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
    this.fillColor,
    this.prefixIconFallback = const SizedBox(),
    this.controller,
  });

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
  final Function()? onEditComplated;
  final Color? fillColor;
  final TextEditingController? controller;

  @override
  _TitleAndInputTextState createState() => _TitleAndInputTextState();
}

class _TitleAndInputTextState extends State<TitleAndInputText> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
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
          cursorColor: widget.isValid ? null : Colors.black,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              maxHeight: 50,
              minHeight: 42,
            ),
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isValid ? Colors.grey : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isValid ? Colors.blue : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isValid ? Colors.grey : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: AppColors.gray500,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            prefixIconColor: widget.isValid ? null : Colors.transparent,
            prefixIcon: widget.prefixIcon,
            suffixIcon: !widget.obscureText
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          obscureText: _obscureText,
        ),
      ],
    );
  }
}
