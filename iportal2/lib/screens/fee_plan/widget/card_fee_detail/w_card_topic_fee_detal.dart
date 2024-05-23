import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/widget/card_fee_detail/w_card_fee_detail.dart';

class CardTopicDetailFeePlan extends StatefulWidget {
  const CardTopicDetailFeePlan({
    super.key,
    required this.feeCategoryData,
    required this.titleTopic,
  });

  final FeeCategoryData feeCategoryData;
  final String titleTopic;

  @override
  State<CardTopicDetailFeePlan> createState() => _CardTopicDetailFeePlanState();
}

class _CardTopicDetailFeePlanState extends State<CardTopicDetailFeePlan> {
  late List<bool> listSelected;

  @override
  void initState() {
    listSelected =
        List.filled(widget.feeCategoryData.items?.length ?? 0, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FeePlanBloc>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.feeCategoryData.title ?? '',
            style: AppTextStyles.bold16(color: AppColors.brand600),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(
              widget.feeCategoryData.items?.length ?? 0,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _onChoose(index, !listSelected[index], context);
                    });
                  },
                  child: CardFeeDetail(
                    feeItem: widget.feeCategoryData.items?[index] ?? FeeItem(),
                    isSelected: listSelected[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onChoose(int index, bool isSelected, BuildContext context) {
    setState(() {
      listSelected[index] = isSelected;
      if (isSelected) {
        context.read<FeePlanBloc>().add(
              AddFeeToListVerify(
                  feeItem: widget.feeCategoryData.items?[index] ?? FeeItem()),
            );
      } else {
        context.read<FeePlanBloc>().add(
              RemoveFeeFromListVerify(
                  feeItem: widget.feeCategoryData.items?[index] ?? FeeItem()),
            );
      }
    });
  }
}
