import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';

class CardDetailSchoolFeePayment extends StatelessWidget {
  const CardDetailSchoolFeePayment(
      {required this.item, this.isShowDetail = false, super.key});
  final bool isShowDetail;
  final SchoolFeeItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Học phí",
                              style: AppTextStyles.normal14(
                                  color: AppColors.brand600,
                                  fontWeight: FontWeight.w500),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 200),
                                sizeCurve: Curves.linear,
                                secondCurve: Curves.easeIn,
                                firstCurve: Curves.easeOut,
                                crossFadeState: isShowDetail
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                firstChild: const Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColors.brand600,
                                  size: 30,
                                ),
                                secondChild: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.brand600,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                        AutoSizeText(
                          "${item.noidung}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                          style:
                              AppTextStyles.bold14(color: AppColors.brand600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            deadlineTuitionBuild(item.hanNop ?? ""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FieldRowCardDetail(
                title: 'Hạn nộp',
                value: item.hanNop?.ddMMYYYSlash ?? "",
                titleStyle: AppTextStyles.normal14(
                  color: AppColors.gray600,
                ),
                valueStyle: AppTextStyles.normal14(
                  color: AppColors.gray700,
                ),
                isLastItem: true,
              ),
            ),
            isShowDetail
                ? const Divider(
                    color: AppColors.gray300,
                    height: 1,
                  )
                : const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Divider(
                      color: AppColors.gray300,
                      height: 1,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (isShowDetail)
                    FieldRowCardDetail(
                      title: 'Phí niêm yết',
                      value:
                          '${NumberFormatUtils.displayMoney(double.parse('${item.phiNiemYet ?? 0}'))}/học phần',
                      titleStyle: AppTextStyles.normal14(
                        color: AppColors.gray600,
                      ),
                      valueStyle: AppTextStyles.semiBold14(
                        color: AppColors.gray700,
                      ),
                    ),
                  if (isShowDetail)
                    FieldRowCardDetail(
                      title: 'Giảm giá',
                      value:
                          '${NumberFormatUtils.displayMoney(double.parse('${item.giamGia ?? 0}'))}',
                      titleStyle: AppTextStyles.normal14(
                        color: AppColors.gray600,
                      ),
                      valueStyle: AppTextStyles.semiBold14(
                        color: AppColors.gray700,
                      ),
                    ),
                  FieldRowCardDetail(
                    title: 'Phải nộp',
                    value:
                        '${NumberFormatUtils.displayMoney(double.parse('${item.chuaNop ?? 0}'))}',
                    titleStyle: AppTextStyles.normal14(
                      color: AppColors.brand500,
                    ),
                    valueStyle: AppTextStyles.semiBold14(
                      color: AppColors.brand500,
                    ),
                    isLastItem: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deadlineTuitionBuild(String deadlineTuition) {
    final deadline = deadlineTuition.toDDMMYYYY;
    final now = DateTime.now();
    final daysDifference = deadline?.difference(now).inDays ?? 0;

    Widget buildMessage(String message, [Color? color]) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
            color: AppColors.paymentDeadlineApproaching,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info,
                color: AppColors.paymentDeadlineApproachingText,
              ),
              const SizedBox(width: 5),
              Text(
                message,
                style: AppTextStyles.normal14(
                    color: AppColors.paymentDeadlineApproachingText,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      );
    }

    if (daysDifference < 0) {
      return buildMessage("Đã quá hạn");
    } else if (daysDifference == 0) {
      return buildMessage("Tới hạn nộp");
    } else if (daysDifference < 5) {
      return buildMessage("Sắp tới hạn nộp");
    } else {
      return const SizedBox();
    }
  }
}
