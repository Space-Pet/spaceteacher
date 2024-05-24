import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/screen/school_fee_payment_screen.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomRefresh(
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Tiền còn thừa",
                        style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w400)),
                    Text(
                      "${NumberFormatUtils.displayMoney(
                        NumberFormatUtils.parseDouble("1000000"),
                      )}",
                      style: AppTextStyles.bold14(color: AppColors.green700),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      side: const BorderSide(
                        color: AppColors.brand600,
                      )),
                  child: Text(
                    "Cấn trừ",
                    style: AppTextStyles.bold14(
                      color: AppColors.brand600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tổng cộng:",
                    style: AppTextStyles.normal14(fontWeight: FontWeight.w400)),
                Text(
                  "${NumberFormatUtils.displayMoney(
                    NumberFormatUtils.parseDouble("1000000"),
                  )}",
                  style: AppTextStyles.bold14(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(const SchoolFeePaymentScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red90001,
            ),
            child: Text(
              'Nộp phí',
              style: AppTextStyles.semiBold16(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
