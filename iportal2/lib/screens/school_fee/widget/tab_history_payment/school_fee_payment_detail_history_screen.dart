import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';
import 'package:iportal2/screens/school_fee/model/history_school_fee_payment.dart';

class SchoolFeeDetailHistoryPayment extends StatelessWidget {
  const SchoolFeeDetailHistoryPayment({required this.item, super.key});
  final HistorySchoolFeePayment item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.gray200,
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
                  titleStyle: AppTextStyles.normal14(color: AppColors.gray700),
                  valueStyle:
                      AppTextStyles.semiBold14(color: AppColors.gray700),
                  value: "${item.billId}",
                  isLastItem: false,
                ),
                FieldRowCardDetail(
                    title: "Ngày thu",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: DateFormat("dd/MM/yyyy")
                        .format(
                          DateFormat("dd-MM-yyyy")
                              .parse(item.paymentDate ?? ""),
                        )
                        .toString(),
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Hình thức thu",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: '${item.paymentMethod}',
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Số tiền",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.amount}')) ??
                        "",
                    isLastItem: false),
              ],
            ),
          ),
          Column(
              children: List.generate(
            2,
            ((index) => _CardDetailHistorySchoolFeePayment(item: item)),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ẩn bớt",
                  style: AppTextStyles.bold14(
                    color: AppColors.brand600,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_up, color: AppColors.brand600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardDetailHistorySchoolFeePayment extends StatelessWidget {
  const _CardDetailHistorySchoolFeePayment({required this.item});
  final HistorySchoolFeePayment item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                FieldRowCardDetail(
                  title: "Nội dung thu",
                  titleStyle: AppTextStyles.normal14(color: AppColors.gray700),
                  valueStyle:
                      AppTextStyles.semiBold14(color: AppColors.gray700),
                  value: "${item.billId}",
                  isLastItem: false,
                ),
                FieldRowCardDetail(
                    title: "Niêm yết",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.amount}')) ??
                        "",
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Giảm/cấn trừ",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.amount}')) ??
                        "",
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Thực thu",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.amount}')) ??
                        "",
                    isLastItem: false),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
