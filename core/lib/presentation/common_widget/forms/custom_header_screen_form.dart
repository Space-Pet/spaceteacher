import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants.dart';
import '../../../common/utils/common_function.dart';
import '../../theme/theme_color.dart';
import '../after_layout.dart';

class CustomHeaderScreenForm extends StatefulWidget {
  final String? title;
  final String? des;
  final Widget? child;
  final Color? bgColor;
  final Color? headerColor;
  final String? customBannerImage;
  final bool showHeaderImage;
  final List<Widget> actions;
  final void Function()? onBack;
  final bool? resizeToAvoidBottomInset;
  final Widget header;
  final bool showBackButton;
  final Widget? backButton;
  final double imageBackgroundHeight;
  final EdgeInsetsGeometry? headerPadding;

  const CustomHeaderScreenForm({
    Key? key,
    this.showHeaderImage = true,
    this.title,
    this.des,
    this.child,
    this.bgColor,
    this.headerColor,
    this.customBannerImage,
    this.actions = const <Widget>[],
    this.onBack,
    this.resizeToAvoidBottomInset,
    required this.header,
    this.showBackButton = true,
    this.backButton,
    this.imageBackgroundHeight = 350,
    this.headerPadding,
  }) : super(key: key);

  @override
  State<CustomHeaderScreenForm> createState() => _CustomHeaderScreenFormState();
}

class _CustomHeaderScreenFormState extends State<CustomHeaderScreenForm>
    with AfterLayoutMixin {
  late ThemeData _theme;

  TextTheme get textTheme => _theme.textTheme;

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.showHeaderImage) {
      themeColor.setDarkStatusBar();
    } else {
      themeColor.setLightStatusBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

    final mediaQueryData = MediaQuery.of(context);
    final padding = mediaQueryData.padding;

    final main = Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: padding.top),
          color: widget.headerColor ?? Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.title?.isNotEmpty == true) _buildAppBarTitle(),
              Padding(
                padding: widget.headerPadding ??
                    EdgeInsets.only(
                      top: widget.title?.isNotEmpty == true ? 24 : 0,
                      bottom: 16,
                    ),
                child: widget.header,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: widget.bgColor ?? themeColor.white,
            child: widget.child ?? const SizedBox(),
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: () => CommonFunction.hideKeyBoard(context),
      child: Scaffold(
        body: widget.showHeaderImage == true
            ? Stack(
                children: [
                  Image.asset(
                    coreImageConstant.imgLongHeader,
                    height: widget.imageBackgroundHeight,
                    fit: BoxFit.fitHeight,
                  ),
                  main,
                ],
              )
            : main,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    const textColor = Colors.white;

    final desTextColor =
        widget.showHeaderImage == true ? Colors.white.withOpacity(0.7) : null;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: widget.showBackButton ? 4 : 16),
            if (widget.showBackButton)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: IconButton(
                  onPressed: widget.onBack ?? () => Navigator.pop(context),
                  icon: widget.backButton ??
                      SvgPicture.asset(
                        coreImageConstant.icArrowLeft,
                        width: 22,
                        height: 22,
                        color: textColor,
                      ),
                ),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: widget.actions.isEmpty ? 24 : 8,
                  top: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      widget.title ?? '',
                      style: _theme.textTheme.headline3?.copyWith(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    if (widget.des?.isNotEmpty == true)
                      const SizedBox(height: 4),
                    if (widget.des?.isNotEmpty == true)
                      Text(
                        widget.des ?? '',
                        style: _theme.textTheme.subtitle2?.copyWith(
                          color: desTextColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ...widget.actions,
          ],
        ),
      ],
    );
  }
}
