import 'package:flutter/material.dart';
import 'package:core/resources/app_colors.dart';
import 'package:iportal2/resources/assets.gen.dart';

class LoadingWithBrand extends StatelessWidget {
  const LoadingWithBrand({
    super.key,
    this.isSmallSize = false,
  });

  final bool isSmallSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmallSize ? 40 : 80,
      height: isSmallSize ? 40 : 80,
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                image: DecorationImage(
                  image: Assets.images.logoApp.icLauncher.provider(),
                  fit: BoxFit.cover,
                ),
              ),
              height: isSmallSize ? 30 : 64,
              width: isSmallSize ? 30 : 64,
            ),
          ),
          Center(
            child: SizedBox(
              height: isSmallSize ? 40 : 80,
              width: isSmallSize ? 40 : 80,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.brand600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
