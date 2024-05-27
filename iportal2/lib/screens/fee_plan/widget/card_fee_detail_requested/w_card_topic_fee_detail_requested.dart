import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'w_card_fee_detail_requested.dart';

class CardTopicFeeDetailRequested extends StatelessWidget {
  const CardTopicFeeDetailRequested({
    super.key,
    required this.feeCategoryData,
    required this.titleTopic,
  });

  final FeeCategoryData? feeCategoryData;
  final String titleTopic;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          titleTopic,
          style: AppTextStyles.bold16(color: AppColors.brand600),
        ),
        const SizedBox(height: 10),
        Column(
          children: List.generate(
            feeCategoryData?.items?.length ?? 0,
            (index) {
              return CardFeeDetailRequested(
                feeItem: feeCategoryData?.items?[index] ?? FeeItem(),
              );
            },
          ),
        ),
      ],
    );
  }
}
