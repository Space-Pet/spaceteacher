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
  final List<bool> _listIsShowDetail = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
      listener: (context, state) {
        switch (state.schoolFeeHistoryStatus) {
          case SchoolFeeHistoryStatus.loaded:
            _listIsShowDetail.clear();
            _listIsShowDetail.addAll(
              List.generate(
                state.historySchoolFee?.historySchoolFeeItems?.length ?? 3,
                (index) => false,
              ),
            );
            break;
          default:
        }
      },
      builder: (context, state) {
        final itemsLength =
            state.historySchoolFee?.historySchoolFeeItems?.length ?? 0;
        if (_listIsShowDetail.length != itemsLength) {
          _listIsShowDetail.clear();
          _listIsShowDetail.addAll(List.filled(itemsLength, false));
        }

        return Skeletonizer(
          enabled:
              state.schoolFeeHistoryStatus == SchoolFeeHistoryStatus.loading,
          child: CustomRefresh(
            onRefresh: () async {
              context.read<SchoolFeeBloc>().add(const FetchSchoolFeeHistory());
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  itemsLength,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index < _listIsShowDetail.length) {
                          _listIsShowDetail[index] = !_listIsShowDetail[index];
                        }
                      });
                    },
                    child: CardDetailSchoolFeeHistoryPayment(
                      item: state.historySchoolFee
                              ?.historySchoolFeeItems?[index] ??
                          HistorySchoolFeeItem(),
                      isShowDetail: _listIsShowDetail.length > index
                          ? _listIsShowDetail[index]
                          : false,
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
