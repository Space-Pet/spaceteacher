import 'package:flutter/material.dart';
import 'package:teacher/resources/resources.dart';

class SettingAppBar extends StatelessWidget {
  final VoidCallback? onBack;
  final String title;
  const SettingAppBar({super.key, required this.onBack, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 18,
              color: AppColors.whiteBackground,
            ),
          ),
          Text(title,
              style: AppTextStyles.normal18(
                  color: AppColors.white, fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
