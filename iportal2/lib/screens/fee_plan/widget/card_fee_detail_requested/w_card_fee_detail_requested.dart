import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../w_field_row_card_detail.dart';

class CardFeeDetailRequested extends StatelessWidget {
  const CardFeeDetailRequested({
    super.key,
    required this.feeItem,
  });
  final FeeItem feeItem;

  // Format date from dd-MM-yyyy to dd/MM/yyyy
  String get date {
    final tryParseDate = (feeItem.date ?? '').toDDMMYYYY;
    return tryParseDate?.ddMMyyyySlash ?? '';
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 9,
                    child: AutoSizeText(
                      feeItem.content ?? "",
                      style: AppTextStyles.bold14(
                        color: AppColors.blueForgorPassword,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
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
                            double.parse('${feeItem.grand_total ?? '0'}')) ??
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
                      value: date,
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
