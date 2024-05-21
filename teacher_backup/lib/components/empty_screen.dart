import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.icons.empty.svg(),
        const SizedBox(height: 12),
        Text(text,
            style: AppTextStyles.semiBold16(
              color: AppColors.gray600,
            ))
      ],
    );
  }
}
