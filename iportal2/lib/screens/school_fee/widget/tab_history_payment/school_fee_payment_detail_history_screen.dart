import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';

class SchoolFeeDetailHistoryPayment extends StatelessWidget {
  const SchoolFeeDetailHistoryPayment({required this.item, super.key});
  final HistorySchoolFeeItem item;
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
                  value: "${item.soPhieuThu}",
                  isLastItem: false,
                ),
                FieldRowCardDetail(
                    title: "Ngày thu",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    // value: item.paymentDate?.ddMMYYYSlash ?? "",
                    value: "${item.ngayThu}",
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
          Column(
              children: List.generate(
            item.chiTietPhiThu?.length ?? 0,
            ((index) => _CardDetailHistorySchoolFeePayment(
                  item: item.chiTietPhiThu![index],
                )),
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
  final ChiTietPhieuThu item;
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
                  value: "${item.noidung}",
                  isLastItem: false,
                ),
                FieldRowCardDetail(
                    title: "Niêm yết",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.soTien ?? 0}')) ??
                        "",
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Giảm/cấn trừ",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.giamGia ?? 0}')) ??
                        "",
                    isLastItem: false),
                FieldRowCardDetail(
                    title: "Thực thu",
                    titleStyle:
                        AppTextStyles.normal14(color: AppColors.gray700),
                    valueStyle:
                        AppTextStyles.semiBold14(color: AppColors.gray700),
                    value: NumberFormatUtils.displayMoney(
                            double.parse('${item.thanhTien ?? 0}')) ??
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
