import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class CardExpandScore extends StatelessWidget {
  const CardExpandScore({
    super.key,
    this.isTimeTableView = false,
    required this.scoreCard,
  });

  final ScoreDataType scoreCard;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                  color: AppColors.backgroundBrandRest2,
                  borderRadius: BorderRadius.circular(14)),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kiểm tra thường xuyên",
                      style: AppTextStyles.normal14(
                        color: AppColors.gray600,
                      ),
                    ),
                    Text(
                      scoreCard.ddgtx!.join(', '),
                      style: AppTextStyles.semiBold14(
                        color: AppColors.brand600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.gray300,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Giữa kỳ",
                      style: AppTextStyles.normal14(
                        color: AppColors.gray600,
                      ),
                    ),
                    Text(
                      scoreCard.ddggk ?? '',
                      style: AppTextStyles.semiBold14(
                        color: AppColors.brand600,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.gray300,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cuối kỳ",
                      style: AppTextStyles.normal14(
                        color: AppColors.gray600,
                      ),
                    ),
                    Text(
                      scoreCard.ddgck ?? '',
                      style: AppTextStyles.semiBold14(
                        color: AppColors.brand600,
                      ),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
