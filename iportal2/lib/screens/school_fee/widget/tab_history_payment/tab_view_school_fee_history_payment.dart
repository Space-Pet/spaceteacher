import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/model/history_school_fee_payment.dart';
import 'package:iportal2/screens/school_fee/widget/tab_history_payment/w_card_detail_school_fee_history_payment.dart';

class TabViewSchoolFeeHistoryPayment extends StatefulWidget {
  const TabViewSchoolFeeHistoryPayment({
    super.key,
  });

  @override
  State<TabViewSchoolFeeHistoryPayment> createState() =>
      _TabViewSchoolFeeHistoryPayment();
}

class _TabViewSchoolFeeHistoryPayment
    extends State<TabViewSchoolFeeHistoryPayment> {
  @override
  Widget build(BuildContext context) {
    return CustomRefresh(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            5,
            (index) => CardDetailSchoolFeeHistoryPayment(
              item: HistorySchoolFeePayment(
                  billId: " PMTM${index}789789789789",
                  paymentDate: '1$index-10-2023',
                  paymentMethod: 'Tiền mặt',
                  amount: 1000000),
            ),
          ),
        ),
      ),
    );
  }
}
