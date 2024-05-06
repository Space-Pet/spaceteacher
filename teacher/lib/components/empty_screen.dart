import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.icons.empty),
        const SizedBox(height: 12),
        Text(text,
            style: AppTextStyles.semiBold16(
              color: AppColors.gray600,
            ))
      ],
    );
  }
}
