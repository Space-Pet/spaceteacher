import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/fee_plan/widget/w_field_row_card_detail.dart';
import 'package:iportal2/screens/school_fee/widget/tab_payment/w_card_detail_school_fee_payment.dart';

class TabViewSchoolFeePayment extends StatefulWidget {
  const TabViewSchoolFeePayment({
    super.key,
  });

  @override
  State<TabViewSchoolFeePayment> createState() => _TabViewSchoolFeePayment();
}

class _TabViewSchoolFeePayment extends State<TabViewSchoolFeePayment>
    with SingleTickerProviderStateMixin {
  late List<bool> isShowDetailList;

  @override
  void initState() {
    isShowDetailList = List.generate(3, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomRefresh(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                3,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowDetailList[index] = !isShowDetailList[index];
                    });
                  },
                  child: CardDetailSchoolFeePayment(
                    isShowDetail: isShowDetailList[index],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 44,
            child: RoundedButton(
              onTap: () {},
              borderRadius: 70,
              padding: EdgeInsets.zero,
              buttonColor: AppColors.red90001,
              child: Text(
                'Nộp phí',
                style: AppTextStyles.semiBold16(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





  // ExpansionTileCustom(
                //   tilePadding: EdgeInsets.zero,
                //   title: Container(
                //     padding: const EdgeInsets.all(10),
                //     margin: const EdgeInsets.only(bottom: 10),
                //     decoration: BoxDecoration(
                //       color: AppColors.gray200,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Container(
                //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                //       decoration: BoxDecoration(
                //         color: AppColors.white,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Column(
                //         children: [
                //           Padding(
                //             padding:
                //                 const EdgeInsets.only(left: 10.0, right: 10),
                //             child: Column(
                //               children: [
                //                 Text(
                //                   "Học phí ",
                //                   style: AppTextStyles.semiBold12(
                //                     color: AppColors.blueForgorPassword,
                //                   ),
                //                   overflow: TextOverflow.ellipsis,
                //                   maxLines: 1,
                //                 ),
                //                 Text(
                //                   "Nộp 4 lần (Theo học phần)",
                //                   style: AppTextStyles.bold14(
                //                     color: AppColors.blueForgorPassword,
                //                   ),
                //                   overflow: TextOverflow.ellipsis,
                //                   maxLines: 1,
                //                 ),
                //               ],
                //             ),
                //           ),
                //           const Divider(
                //             color: AppColors.gray300,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(10),
                //             child: Column(
                //               children: [
                //                 FieldRowCardDetail(
                //                   title: "Phải nộp",
                //                   titleStyle: AppTextStyles.bold12(),
                //                   valueStyle: AppTextStyles.bold12(),
                //                   value: NumberFormatUtils.displayMoney(
                //                           double.parse('0')) ??
                //                       "",
                //                   isLastItem: false,
                //                 ),
                //                 FieldRowCardDetail(
                //                     title: "Phí niêm yết",
                //                     titleStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     valueStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     value: NumberFormatUtils.displayMoney(
                //                             double.parse('1000')) ??
                //                         "",
                //                     isLastItem: false),
                //                 FieldRowCardDetail(
                //                     title: "Giảm giá",
                //                     titleStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     valueStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     value: NumberFormatUtils.displayMoney(
                //                             double.parse('1999')) ??
                //                         "",
                //                     isLastItem: false),
                //                 FieldRowCardDetail(
                //                     title: "Hạn nộp",
                //                     titleStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     valueStyle: AppTextStyles.semiBold12(
                //                         color: AppColors.gray300),
                //                     value: DateFormat("dd/MM/yyyy")
                //                         .format(
                //                           DateFormat("dd-MM-yyyy")
                //                               .parse("31-07-2024"),
                //                         )
                //                         .toString(),
                //                     isLastItem: true),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   children: const [
                //     ListTile(
                //       title: Text("Học phí"),
                //       subtitle: Text("Nộp 4 lần (Theo học phần)"),
                //     ),
                //   ],
                // ),