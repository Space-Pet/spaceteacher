import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/card_expand_nutrition.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/nutrition_model.dart';
import 'package:iportal2/resources/resources.dart';

class CardNutrition extends StatefulWidget {
  const CardNutrition({
    super.key,
    required this.nutritionItem,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
  });
  final NutritionModel nutritionItem;
  final num index;
  final num lastIndex;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;
  @override
  State<CardNutrition> createState() => _CardNutritionState();
}

class _CardNutritionState extends State<CardNutrition> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [3, 3],
      color: AppColors.gray300,
      customPath: (size) => Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
        height: widget.isExpanded ? 194 : 48,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.nutritionItem.dateRecord,
                  style: widget.isExpanded
                      ? AppTextStyles.semiBold14(
                          color: AppColors.gray600,
                        )
                      : AppTextStyles.normal14(
                          color: AppColors.gray600,
                        ),
                ),
                GestureDetector(
                  onTap: widget.onExpansionChanged,
                  child: SvgPicture.asset(
                    'assets/icons/${widget.isExpanded ? 'minus' : 'chevron-down'}.svg',
                  ),
                ),
              ],
            ),
            widget.isExpanded
                ? Expanded(
                    child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: CardExpandNutrition(
                            nutritionItem: widget.nutritionItem)))
                : Container()
          ],
        ),
      ),
    );
  }
}
