import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ScreenAppBar extends StatelessWidget {
  final String title;
  final bool canGoback;
  final VoidCallback? onBack;
  final String? iconRight;
  final VoidCallback? onRight;

  const ScreenAppBar(
      {super.key,
      this.onBack,
      required this.title,
      this.canGoback = false,
      this.onRight,
      this.iconRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(canGoback ? 0 : 22, 48, 22, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (canGoback)
                  InkWell(
                    onTap: onBack,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(22, 0, 8, 0),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 18,
                        color: AppColors.whiteBackground,
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.semiBold18(color: AppColors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (iconRight != null)
            GestureDetector(onTap: onRight, child: SvgPicture.asset(iconRight!))
        ],
      ),
    );
  }
}
