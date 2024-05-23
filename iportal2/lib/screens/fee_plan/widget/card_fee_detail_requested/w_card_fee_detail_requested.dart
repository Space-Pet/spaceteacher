import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';

class CardFeeDetailRequested extends StatelessWidget {
  const CardFeeDetailRequested({
    super.key,
    required this.feeItem,
  });
  final FeeItem feeItem;

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
                  Expanded(
                    flex: 7,
                    child: Text(
                      feeItem.content ?? "",
                      style: AppTextStyles.bold14(
                        color: AppColors.blueForgorPassword,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: Text(
                      feeItem.status ?? "",
                      style: AppTextStyles.semiBold12(
                        color: _getColorBasedOnStatus(feeItem.status ?? ""),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
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
                    title: "Phải nộp",
                    titleStyle: AppTextStyles.bold12(),
                    valueStyle: AppTextStyles.bold12(),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${feeItem.grand_total}')) ??
                        "",
                    isLastItem: false,
                  ),
                  FieldRowCardDetail(
                      title: "Phí niêm yết",
                      titleStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      valueStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      value: NumberFormatUtils.displayMoney(
                              double.parse('${feeItem.price}')) ??
                          "",
                      isLastItem: false),
                  FieldRowCardDetail(
                      title: "Giảm giá",
                      titleStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      valueStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      value: NumberFormatUtils.displayMoney(
                              double.parse('${feeItem.discount}')) ??
                          "",
                      isLastItem: false),
                  FieldRowCardDetail(
                      title: "Hạn nộp",
                      titleStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      valueStyle:
                          AppTextStyles.semiBold12(color: AppColors.gray300),
                      value: DateFormat("dd/MM/yyyy")
                          .format(
                            DateFormat("dd-MM-yyyy").parse(feeItem.date ?? ""),
                          )
                          .toString(),
                      isLastItem: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getColorBasedOnStatus(String status) {
  if (statusText(FeeStatus.requested) == status) {
    return AppColors.amberWarn; // Example color for requested status
  } else if (statusText(FeeStatus.applied) == status) {
    return AppColors.green400; // Example color for applied status
  } else if (statusText(FeeStatus.failed) == status) {
    return AppColors.red90001; // Example color for failed status
  } else {
    return AppColors.gray400; // Default color
  }
}

enum FeeStatus { requested, applied, failed }

String statusText(FeeStatus status) {
  switch (status) {
    case FeeStatus.applied:
      return "Đã áp dụng";
    case FeeStatus.requested:
      return "Gửi duyệt";
    case FeeStatus.failed:
      return "Thất bại";
    default:
      return "Gửi duyệt";
  }
}
