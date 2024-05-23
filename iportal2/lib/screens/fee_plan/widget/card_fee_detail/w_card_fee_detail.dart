import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';

import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';

class CardFeeDetail extends StatefulWidget {
  const CardFeeDetail({
    required this.feeItem,
    super.key,
    required this.isSelected,
  });
  final FeeItem feeItem;
  final bool isSelected;

  @override
  State<CardFeeDetail> createState() => _CardFeeDetailState();
}

class _CardFeeDetailState extends State<CardFeeDetail> {
  bool onValueChanged = false;

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                children: [
                  Text(
                    widget.feeItem.content ?? "",
                    style: AppTextStyles.bold14(
                      color: AppColors.blueForgorPassword,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.isSelected == true
                            ? AppColors.green600
                            : AppColors.gray300,
                      ),
                      color: AppColors.white,
                    ),
                    height: 20,
                    padding: const EdgeInsets.all(3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isSelected == true
                            ? AppColors.green600
                            : AppColors.white,
                      ),
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: AppColors.gray300,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  FieldRowCardDetail(
                    title: widget.feeItem.meta_data?.price?.label ?? "",
                    value: widget.feeItem.meta_data?.price?.price_text ?? "",
                    isLastItem: false,
                  ),
                  Column(
                    children: List.generate(
                        widget.feeItem.meta_data?.items?.length ?? 1, (index) {
                      return FieldRowCardDetail(
                        title:
                            widget.feeItem.meta_data?.items?[index].label ?? "",
                        value: DateFormat("dd/MM/yyyy")
                            .format(
                              DateFormat("dd-MM-yyyy").parse(widget
                                      .feeItem.meta_data?.items?[index].date ??
                                  ""),
                            )
                            .toString(),
                        isLastItem:
                            index == widget.feeItem.meta_data!.items!.length - 1
                                ? true
                                : false,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}