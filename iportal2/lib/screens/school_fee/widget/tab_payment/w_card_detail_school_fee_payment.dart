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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Học phí",
                          style: AppTextStyles.normal14(
                              color: AppColors.brand600,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${item.noidung}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.bold14(color: AppColors.brand600),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                      flex: 3,
                      child: Align(
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
                      )),
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
                valueStyle: AppTextStyles.bold14(
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
                      titleStyle: AppTextStyles.normal16(
                        color: AppColors.gray600,
                      ),
                      valueStyle: AppTextStyles.bold14(
                        color: AppColors.gray700,
                      ),
                    ),
                  if (isShowDetail)
                    FieldRowCardDetail(
                      title: 'Giảm giá',
                      value:
                          '${NumberFormatUtils.displayMoney(double.parse('${item.giamGia ?? 0}'))}',
                      titleStyle: AppTextStyles.normal16(
                        color: AppColors.gray600,
                      ),
                      valueStyle: AppTextStyles.bold14(
                        color: AppColors.gray700,
                      ),
                    ),
                  FieldRowCardDetail(
                    title: 'Phải nộp',
                    value:
                        '${NumberFormatUtils.displayMoney(double.parse('${item.chuaNop ?? 0}'))}',
                    titleStyle: AppTextStyles.normal16(
                      color: AppColors.brand500,
                    ),
                    valueStyle: AppTextStyles.bold14(
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
    final deadline = DateTime.tryParse(deadlineTuition) ?? DateTime.now();
    final now = DateTime.now();
    final daysDifference = deadline.difference(now).inDays;

    Widget buildMessage(String message, Color color) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
            color: daysDifference < 0
                ? AppColors.observationCardDetailDotted
                : color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                color: daysDifference < 0 ? AppColors.primaryRedColor : color,
              ),
              const SizedBox(width: 5),
              Text(
                message,
                style: AppTextStyles.bold14(
                    color:
                        daysDifference < 0 ? AppColors.primaryRedColor : color),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      );
    }

    if (daysDifference < 0) {
      return buildMessage("Đã quá hạn", AppColors.observationCardDetailDotted);
    } else if (daysDifference == 0) {
      return buildMessage("Tới hạn đóng", AppColors.amberWarn);
    } else if (daysDifference <= 5) {
      return buildMessage("Sắp tới hạn đóng", AppColors.amberWarn);
    } else {
      return const SizedBox();
    }
  }
}
