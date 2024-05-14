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
        if (isEnable == true) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        shadowColor: isEnable == true ? AppColors.gray500 : Colors.transparent,
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
            style: AppTextStyles.normal14(
                color: isEnable == true
                    ? AppColors.blueForgorPassword
                    : AppColors.gray500),
          ),
          const SizedBox(
            width: 10,
          ),
          CircleAvatar(
              radius: 12,
              backgroundColor: isEnable == true
                  ? AppColors.blueForgorPassword
                  : AppColors.blueGray500,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: icon,
              )),
        ],
      ),
    );
  }
}
