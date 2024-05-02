import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/assets.gen.dart';

class LoadingWithBrand extends StatelessWidget {
  const LoadingWithBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
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
              height: 60,
              width: 60,
            ),
          ),
          const Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.brand600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
