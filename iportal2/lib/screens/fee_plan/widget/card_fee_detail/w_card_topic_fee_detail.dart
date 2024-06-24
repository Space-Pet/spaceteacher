import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_status.dart';

import 'w_card_fee_detail.dart';

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
  List<bool> listSelected = [];

  @override
  void initState() {
    initListSelected();
    super.initState();
  }

  void initListSelected() {
    final itemLength = widget.feeCategoryData.items?.length ?? 0;
    listSelected = List.generate(
      itemLength,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FeePlanBloc>(),
      child: BlocConsumer<FeePlanBloc, FeePlanState>(
        listener: (context, state) {
          if (state.status == FeePlanStatus.loaded) {
            final itemLength = widget.feeCategoryData.items?.length ?? 0;
            if (itemLength > 0 && listSelected.length < itemLength) {
              listSelected = List.generate(
                itemLength,
                (index) => false,
              );
            }
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isNullOrEmpty(widget.feeCategoryData.items) &&
                  widget.feeCategoryData.items!.any((e) => e.disable == 0))
                Text(
                  widget.feeCategoryData.title ?? '',
                  style: AppTextStyles.bold16(color: AppColors.brand600),
                ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(
                  widget.feeCategoryData.items?.length ?? 0,
                  (index) {
                    if (widget.feeCategoryData.items?[index].disable == 0) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _onChoose(index, !listSelected[index], context);
                          });
                        },
                        child: CardFeeDetail(
                          feeItem:
                              widget.feeCategoryData.items?[index] ?? FeeItem(),
                          isSelected: listSelected.length > index
                              ? listSelected[index]
                              : false,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          );
        },
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
