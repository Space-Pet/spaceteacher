import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardExpandNutrition extends StatelessWidget {
  const CardExpandNutrition({
    super.key,
    this.isTimeTableView = false,
    required this.nutritionItem,
  });

  final DataNutrition nutritionItem;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE3F0FE),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HeightGroup(nutritionItem: nutritionItem),
              const SizedBox(
                height: 12,
              ),
              WeightGroup(nutritionItem: nutritionItem)
            ],
          ),
          BMIGroup(nutritionItem: nutritionItem)
        ],
      ),
    );
  }
}

class BMIGroup extends StatelessWidget {
  const BMIGroup({
    super.key,
    required this.nutritionItem,
  });

  final DataNutrition nutritionItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE3F0FE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
            ),
            child: Row(
              children: [
                Text(
                  'BMI',
                  style: AppTextStyles.normal14(color: AppColors.gray600),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  nutritionItem.bmi.toString(),
                  style: AppTextStyles.bold16(color: AppColors.lightBlue600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Text(
              nutritionItem.ketLuan,
              textAlign: TextAlign.left,
              style: AppTextStyles.semiBold14(color: AppColors.brand600),
            ),
          ),
        ],
      ),
    );
  }
}

class WeightGroup extends StatelessWidget {
  const WeightGroup({
    super.key,
    required this.nutritionItem,
  });

  final DataNutrition nutritionItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: AppColors.lightSkyBlue,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 8,
          ),
          child: SvgPicture.asset(
            'assets/icons/nutri-weight.svg',
            height: 32,
            width: 32,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cân nặng",
              style: AppTextStyles.normal14(color: AppColors.black24),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              nutritionItem.weight.toString(),
              style: AppTextStyles.semiBold14(color: AppColors.black24),
            )
          ],
        )
      ],
    );
  }
}

class HeightGroup extends StatelessWidget {
  const HeightGroup({
    super.key,
    required this.nutritionItem,
  });

  final DataNutrition nutritionItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: AppColors.lightSkyBlue,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: SvgPicture.asset(
            'assets/icons/nutri-height.svg',
            height: 32,
            width: 32,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chiều cao",
              style: AppTextStyles.normal14(color: AppColors.black24),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              nutritionItem.height.toString(),
              style: AppTextStyles.semiBold14(color: AppColors.black24),
            )
          ],
        )
      ],
    );
  }
}
