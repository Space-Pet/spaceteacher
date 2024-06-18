import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/nutrition_heath/widget/nutrition_card/card_expand_nutrition.dart';

class CardNutrition extends StatefulWidget {
  const CardNutrition({
    super.key,
    required this.nutritionItem,
    required this.index,
    required this.lastIndex,
    required this.isExpanded,
    required this.onExpansionChanged,
  });
  final DataNutrition nutritionItem;
  final num index;
  final bool lastIndex;
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
      color: widget.lastIndex ? AppColors.white : AppColors.gray300,
      customPath: (size) => Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
        height: widget.isExpanded ? 220 : 48,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tháng ${widget.nutritionItem.month}',
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
                    'assets/icons/${widget.isExpanded ? 'chevron-up' : 'chevron-down'}.svg',
                  ),
                ),
              ],
            ),
            if (widget.isExpanded)
              Expanded(
                  child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: CardExpandNutrition(
                          nutritionItem: widget.nutritionItem)))
          ],
        ),
      ),
    );
  }
}
