import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
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
    return BlocBuilder<SchoolFeeBloc, SchoolFeeState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.schoolFeeStatus == SchoolFeeStatus.loading,
          child: CustomRefresh(
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
                      item: state.historySchoolFee
                              ?.historySchoolFeeItems?[index] ??
                          HistorySchoolFeeItem(),
                      isShowDetail: _listIsShowDetail[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
