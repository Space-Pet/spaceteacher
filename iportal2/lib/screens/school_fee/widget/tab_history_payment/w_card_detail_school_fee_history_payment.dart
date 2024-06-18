import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';
import 'package:iportal2/screens/school_fee/widget/tab_history_payment/school_fee_payment_detail_history_screen.dart';

class CardDetailSchoolFeeHistoryPayment extends StatelessWidget {
  const CardDetailSchoolFeeHistoryPayment(
      {required this.item, this.isShowDetail = false, super.key});
  final HistorySchoolFeeItem item;

  // Parse dd-MM-yyyy to dd/MM/yyyy
  String parseDate(String? date) {
    return date?.toDDMMYYYY?.ddMMyyyySlash ?? '';
  }

  final bool isShowDetail;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Container(
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    FieldRowCardDetail(
                      title: "Số biên lai",
                      titleStyle:
                          AppTextStyles.normal14(color: AppColors.gray700),
                      valueStyle:
                          AppTextStyles.semiBold14(color: AppColors.gray700),
                      value: "${item.soPhieuThu}",
                      isLastItem: false,
                    ),
                    FieldRowCardDetail(
                        title: "Ngày thu",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value: item.ngayThu ?? "",
                        isLastItem: false),
                    FieldRowCardDetail(
                        title: "Hình thức thu",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value: '${item.hinhThucThanhToan}',
                        isLastItem: false),
                    FieldRowCardDetail(
                        title: "Số tiền",
                        titleStyle:
                            AppTextStyles.normal14(color: AppColors.gray700),
                        valueStyle:
                            AppTextStyles.semiBold14(color: AppColors.gray700),
                        value: NumberFormatUtils.displayMoney(
                                double.parse('${item.soTien ?? 0}')) ??
                            "",
                        isLastItem: false),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Xem chi tiết",
                      style: AppTextStyles.bold14(
                        color: AppColors.brand600,
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.brand600),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      secondChild: SchoolFeeDetailHistoryPayment(item: item),
      duration: const Duration(milliseconds: 300),
      crossFadeState: isShowDetail == false
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}
