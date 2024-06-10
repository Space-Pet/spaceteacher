import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class CardExpandScore extends StatelessWidget {
  const CardExpandScore({
    super.key,
    this.isTimeTableView = false,
    required this.scoreCard,
  });

  final ScoreDataType? scoreCard;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundBrandRest2,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _buildScoreRow(
                          context,
                          "Kiểm tra thường xuyên",
                          ['2.3', '2,4', '3', '3'] ?? [],
                          maxScores: 4,
                        ),
                        _buildDivider(),
                        _buildScoreRow(
                          context,
                          "Giữa kỳ",
                          [scoreCard?.ddggk],
                          maxScores: 1,
                        ),
                        _buildDivider(),
                        _buildScoreRow(
                          context,
                          "Cuối kỳ",
                          [scoreCard?.ddgck],
                          maxScores: 1,
                        ),
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

  Widget _buildScoreRow(
      BuildContext context, String title, List<String?> scores,
      {required int maxScores}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.normal14(
            color: AppColors.gray600,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...List.generate(maxScores, (index) {
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: TextEditingController(
                          text: index < scores.length ? scores[index] : ''),
                      onChanged: (value) {
                        if (index < scores.length) {
                          scores[index] = value;
                        } else {
                          scores.add(value);
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.gray300), // Bottom border
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                      ),
                      style: AppTextStyles.semiBold14(
                        color: AppColors.brand600,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 8),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.gray300,
          ),
        ),
      ),
    );
  }
}
