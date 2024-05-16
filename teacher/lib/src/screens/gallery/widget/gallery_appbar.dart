import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

import 'package:teacher/src/utils/extension_context.dart';

class AppBarGallery extends StatelessWidget {
  const AppBarGallery({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 18,
              color: AppColors.black24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Text(
              name,
              style: AppTextStyles.semiBold18(color: AppColors.black24),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
