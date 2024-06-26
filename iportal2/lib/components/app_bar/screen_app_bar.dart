import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/resources.dart';

class ScreensAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScreensAppBar(
    this.title, {
    super.key,
    this.elevation = 0,
    this.centerTitle = false,
    this.actionWidget,
    this.bottom,
    this.canGoBack = false,
    this.automaticallyImplyLeading = true,
    this.onBack,
  }) : preferredSize = const Size.fromHeight(44.0);

  final String title;
  final double elevation;
  final bool centerTitle;
  final Widget? actionWidget;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final bool canGoBack;
  final VoidCallback? onBack;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: canGoBack ? 60 : 40,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: bottom,
      titleSpacing: -10,
      leading: canGoBack
          ? InkWell(
              onTap: onBack ??
                  () {
                    context.pop();
                  },
              child: const Icon(
                Icons.arrow_back_ios_sharp,
                color: AppColors.white,
                size: 18,
              ),
            )
          : const SizedBox(),
      title:
          Text(title, style: AppTextStyles.semiBold18(color: AppColors.white)),
      actions: [
        if (actionWidget != null) actionWidget! else const SizedBox(),
      ],
    );
  }
}
