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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        '${NumberFormatUtils.displayMoney(double.parse('${item.phaiNop ?? 0}'))}',
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
}
