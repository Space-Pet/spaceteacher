import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenAppBar extends StatelessWidget {
  final String title;
  final bool canGoback;
  final bool hasUpdateYear;
  final VoidCallback? onBack;
  final String? iconRight;
  final VoidCallback? onRight;
  final VoidCallback? onOpenIcon;
  final String? icon;
  final Widget? iconWidget;

  const ScreenAppBar(
      {super.key,
      this.onBack,
      this.onOpenIcon,
      this.iconWidget,
      this.icon,
      required this.title,
      this.canGoback = false,
      this.onRight,
      this.hasUpdateYear = false,
      this.iconRight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (canGoback)
                GestureDetector(
                  onTap: onBack,
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                ),
              const SizedBox(width: 8),
              Text(title,
                  style: AppTextStyles.semiBold18(color: AppColors.white)),
            ],
          ),
          if (hasUpdateYear)
            GestureDetector(
              onTap: onOpenIcon,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.blackTransparent),
                  child: iconWidget),
            ),
          if (iconRight != null)
            GestureDetector(
              onTap: onRight,
              child: SvgPicture.asset(
                iconRight!,
                color: AppColors.white,
                width: 24,
              ),
            )
        ],
      ),
    );
  }
}
