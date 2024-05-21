import 'package:flutter/material.dart';

import 'package:core/resources/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:teacher/resources/assets.gen.dart';

class ScreenAppBar extends StatelessWidget {
  final String title;
  final bool canGoback;
  final bool hasUpdateYear;
  final VoidCallback? onBack;
  final VoidCallback? onOpenIcon;
  final String? icon;

  const ScreenAppBar({
    super.key,
    this.onBack,
    this.onOpenIcon,
    this.icon,
    this.hasUpdateYear = false,
    required this.title,
    this.canGoback = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        mainAxisAlignment: hasUpdateYear
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          if (canGoback)
            Row(
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          Text(title, style: AppTextStyles.semiBold18(color: AppColors.white)),
          if (hasUpdateYear)
            GestureDetector(
              onTap: onOpenIcon,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.blackTransparent),
                child: SvgPicture.asset(icon ?? ''),
              ),
            )
        ],
      ),
    );
  }
}
