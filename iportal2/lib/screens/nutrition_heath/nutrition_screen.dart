import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/card_nutrition.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/nutrition_model.dart';
import 'package:iportal2/screens/student_score/widget/app_bar_score.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});
  static const routeName = '/nutrition-health';
  @override
  State<NutritionScreen> createState() => NutritionScreenState();
}

class NutritionScreenState extends State<NutritionScreen> {
  int? expandedIndex;
  void _handleExpansion(int index) {
    if (index == expandedIndex) {
      setState(() {
        expandedIndex = null;
      });
    } else {
      setState(() {
        expandedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double calculatedHeight = screenHeight - 72 - 184 - 34;
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Sức khỏe dinh dưỡng',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.roundedTop28,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppBarScore(),
                              Text(
                                "Sức khoẻ dinh dưỡng năm học 2023 -2024",
                                style: AppTextStyles.semiBold16(
                                    color: AppColors.brand600),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: calculatedHeight,
                          padding: const EdgeInsets.all(12),
                          decoration: ShapeDecoration(
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: AppColors.blueGray100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: AppColors.gray9000c,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                ...List.generate(
                                    nutritionList.length,
                                    (index) => CardNutrition(
                                        isExpanded: expandedIndex == index,
                                        index: index,
                                        onExpansionChanged: () =>
                                            _handleExpansion(index),
                                        nutritionItem: nutritionList[index],
                                        lastIndex: nutritionList.length - 1))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
