import 'package:flutter/material.dart';

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
  late List<bool> _listIsShowDetail;

  @override
  void initState() {
    _listIsShowDetail = List.generate(5, (index) => false);
    super.initState();
  }

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
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _listIsShowDetail[index] = !_listIsShowDetail[index];
                });
              },
              child: CardDetailSchoolFeeHistoryPayment(
                item: HistorySchoolFeePayment(
                    billId: " PMTM${index}789789789789",
                    paymentDate: '1$index-10-2023',
                    paymentMethod: 'Tiền mặt',
                    amount: 1000000),
                isShowDetail: _listIsShowDetail[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
