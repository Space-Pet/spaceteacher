import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/home/models/feature_model.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.feature,
    required this.isPinned,
    required this.isUpdatePin,
    required this.isKinderGarten,
    this.gradeLevel,
    this.isPinnedList = false,
    this.isInBottomSheet = false,
  });

  final FeatureModel feature;
  final FeatureGradeLevel? gradeLevel;
  final bool isPinned;
  final bool isUpdatePin;
  final bool isPinnedList;
  final bool isInBottomSheet;
  final bool isKinderGarten;

  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width - (isInBottomSheet ? 40 : 32);

    final iconAction = isPinnedList
        ? 'close-gray-circle'
        : isPinned
            ? 'check-circle-green'
            : 'add-circle-darkblue';

    return SizedBox(
      width: w / 4,
      height: 90.v,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Center(
                child: Container(
                  width: 52.h,
                  height: 52.v,
                  decoration: isKinderGarten
                      ? feature.category == FeatureCategory.all
                          ? BoxDecoration(
                              gradient: _buildGradient(FeatureGradient.gray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            )
                          : const BoxDecoration()
                      : BoxDecoration(
                          gradient: _buildGradient(
                              feature.gradientType ?? FeatureGradient.gray),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                  child: Center(
                      child: SvgPicture.asset(
                          '${isKinderGarten ? feature.preSIcon : feature.highSIcon}')),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  feature.name.tr(),
                  style: AppTextStyles.custom(
                      fontSize: isInBottomSheet ? 10.fSize : 12.fSize,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: AppColors.black.withOpacity(0.9)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (isUpdatePin)
            Positioned(
              top: -4,
              right: 6,
              child: SvgPicture.asset('assets/icons/$iconAction.svg'),
            )
        ],
      ),
    );
  }
}

Gradient _buildGradient(FeatureGradient typeGradient) {
  List<Color> gradientColors = [];
  switch (typeGradient) {
    case FeatureGradient.darkblue:
      gradientColors = const [
        Color(0xFF5FCFF4),
        Color(0xFF4A89FD),
      ];
      break;

    case FeatureGradient.lightblue:
      gradientColors = const [
        Color(0xFF74E5F7),
        Color(0xFF45A4DE),
      ];
      break;

    case FeatureGradient.orange:
      gradientColors = const [
        Color(0xFFF9A66A),
        Color(0xFFFD634D),
      ];
      break;

    case FeatureGradient.green:
      gradientColors = const [
        Color(0xFF69E8CD),
        Color(0xFF2FD1AF),
      ];
      break;

    case FeatureGradient.yellow:
      gradientColors = const [
        Color(0xFFF4CC46),
        Color(0xFFF88F33),
      ];
      break;

    default:
      gradientColors = const [
        AppColors.gray400,
        AppColors.gray400,
      ];
  }

  return LinearGradient(
    colors: gradientColors,
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    transform: const GradientRotation(147 * 3.14159 / 180),
    stops: const [0.0955, 0.888],
  );
}
