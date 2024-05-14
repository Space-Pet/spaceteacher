import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class ButtonActionDetailGallery extends StatelessWidget {
  const ButtonActionDetailGallery({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.isEnable,
  });

  final Function() onPressed;
  final String title;
  final Widget icon;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.rounded20,
          side: const BorderSide(
            color: AppColors.gray500,
          ),
        ),
        padding: const EdgeInsets.all(10),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.normal14(color: AppColors.gray500),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.blueGray500,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon,
              )),
        ],
      ),
    );
  }
}
