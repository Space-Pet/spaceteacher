import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_color.dart';

part 'input_container.controller.dart';

enum InputStyle { normal, circular }

class InputContainer extends StatefulWidget {
  final InputContainerController? controller;
  final String? hint;
  final bool isPassword;
  final bool readOnly;
  final bool enable;
  final bool required;
  final bool enableFocusEffect;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function()? onTap;
  final Function(String)? onTextChanged;
  final int? maxLines;
  final int? minLines;
  final String? title;
  final Widget? prefixIcon;
  final InputStyle? inputStyle;
  final bool hasBorder;
  final int? maxLength;
  final double radius;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? suffixIconPadding;
  final EdgeInsetsGeometry? prefixIconPadding;
  final TextStyle? titleTextStyle;
  final bool? isDense;

  InputContainer({
    Key? key,
    this.controller,
    this.hint,
    this.isPassword = false,
    this.readOnly = false,
    this.enable = true,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onTextChanged,
    this.maxLines = 1,
    this.minLines,
    this.title,
    this.prefixIcon,
    this.inputStyle = InputStyle.circular,
    this.hasBorder = true,
    this.maxLength,
    this.radius = 6,
    this.contentPadding,
    this.fillColor,
    this.inputFormatters,
    this.textAlign = TextAlign.left,
    this.suffixText,
    this.textInputAction,
    this.required = false,
    this.suffixIconPadding,
    this.prefixIconPadding,
    this.enableFocusEffect = true,
    this.titleTextStyle,
    this.isDense,
  }) : super(key: key);

  @override
  State<InputContainer> createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  bool get hasSuffixIcon => widget.isPassword || widget.suffixIcon != null;

  double get suffixIconSize => hasSuffixIcon ? 16 : 0;

  double get prefixIconSize => widget.prefixIcon != null ? 16 : 0;

  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return ValueListenableBuilder<InputContainerProperties>(
      valueListenable: widget.controller ?? InputContainerController(),
      builder: (ctx, value, w) {
        late Widget body;
        final textField = TextField(
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          buildCounter: widget.maxLength != null
              ? (
                  _, {
                  required currentLength,
                  maxLength,
                  required isFocused,
                }) =>
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      '($currentLength/$maxLength)',
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  )
              : null,
          focusNode: value.focusNode,
          readOnly: widget.readOnly || !widget.enable,
          controller: value.tdController,
          decoration: InputDecoration(
            isDense: widget.isDense,
            suffixStyle: TextStyle(
              color: themeColor.red,
            ),
            filled: widget.inputStyle == InputStyle.circular,
            fillColor: widget.enable
                ? widget.fillColor ?? themeColor.white
                : themeColor.colorF0F0F5,
            border: _getNonFocusBorder(),
            enabledBorder: _getNonFocusBorder(),
            focusedBorder: _getFocusBorder(),
            focusColor: widget.enableFocusEffect == true
                ? themeColor.primaryColor
                : null,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
            hintText: widget.hint,
            hintStyle: themeData.textTheme.titleSmall?.copyWith(),
            errorText: value.validation,
            errorStyle: themeData.textTheme.titleMedium?.copyWith(
              color: Colors.red,
              fontSize: value.validation?.isNotEmpty == true ? null : 1,
            ),
            suffixIcon: Padding(
              padding: widget.suffixIconPadding ??
                  EdgeInsets.symmetric(horizontal: suffixIconSize),
              child: _getSuffixIcon(),
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: suffixIconSize,
              minWidth: suffixIconSize,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: widget.prefixIconPadding ??
                        EdgeInsets.symmetric(horizontal: prefixIconSize),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minHeight: prefixIconSize,
              minWidth: prefixIconSize,
            ),
            suffixText: widget.suffixText,
          ),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          style: themeData.textTheme.bodyMedium,
          obscureText:
              widget.isPassword && widget.controller?.isShowPass != true,
          onChanged: (text) {
            if (value.validation != null) {
              widget.controller?.resetValidation();
            }
            widget.onTextChanged?.call(text);
          },
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onTap: widget.onTap,
          inputFormatters: widget.inputFormatters,
        );
        if (widget.title?.isNotEmpty == true) {
          body = Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _titleText(),
              ),
              const SizedBox(height: 6),
              textField,
            ],
          );
        } else {
          body = textField;
        }
        return Theme(
          data: themeData.copyWith(
            primaryColor: themeData.colorScheme.secondary,
            primaryColorDark: themeData.colorScheme.secondary,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: themeColor.greyE5,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: widget.hasBorder
                    ? BorderSide(
                        color: themeColor.greyE5,
                        width: 1,
                      )
                    : const BorderSide(style: BorderStyle.none),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
          child: body,
        );
      },
    );
  }

  Widget _titleText() {
    return Text.rich(
      TextSpan(
        text: widget.title,
        children: <InlineSpan>[
          if (widget.required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
        style: widget.titleTextStyle ??
            themeData.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      final icon = widget.suffixIcon ?? _getPasswordIcon();
      return InkWell(
        onTap: widget.controller?.showOrHidePass,
        child: icon,
      );
    }
    return widget.suffixIcon;
  }

  InputBorder? _getNonFocusBorder() {
    return widget.inputStyle == InputStyle.normal
        ? UnderlineInputBorder(
            borderSide: BorderSide(
              color: themeColor.greyE5,
              width: 1,
            ),
          )
        : OutlineInputBorder(
            borderSide: widget.hasBorder
                ? BorderSide(
                    color: themeColor.greyE5,
                    width: 1,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(widget.radius),
          );
  }

  InputBorder? _getFocusBorder() {
    return widget.inputStyle == InputStyle.normal
        ? UnderlineInputBorder(
            borderSide: BorderSide(
              color: themeData.colorScheme.primary,
              width: 1,
            ),
          )
        : OutlineInputBorder(
            borderSide: widget.hasBorder
                ? BorderSide(
                    color: widget.enableFocusEffect == true
                        ? themeData.colorScheme.primary
                        : themeColor.greyE5,
                    width: 1,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(widget.radius),
          );
  }

  Widget _getPasswordIcon() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Icon(
        widget.controller?.isShowPass == true
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
}
