import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgePreSchool extends StatelessWidget {
  const BadgePreSchool({super.key, required this.huyHieuName});
  final String huyHieuName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: GradientBorderContainer(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFCC46), Color(0xFFF88F33)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: 90.0,
          bgColor: const Color(0xFFFFFAEB),
          padding: 1.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/Emoji Funny Square.svg',
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                huyHieuName,
                style: AppTextStyles.semiBold16(
                  color: AppColors.amberWarn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Color bgColor;
  final double borderRadius;
  final double borderWidth;
  final double padding;

  const GradientBorderContainer({
    super.key,
    required this.child,
    required this.gradient,
    required this.bgColor,
    this.borderRadius = 0.0,
    this.borderWidth = 0.0,
    this.padding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor, // Change this to your desired inner background color
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          child: child,
        ),
      ),
    );
  }
}
