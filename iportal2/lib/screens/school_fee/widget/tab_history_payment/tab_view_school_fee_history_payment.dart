import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_status.dart';
import 'package:iportal2/screens/school_fee/widget/tab_history_payment/w_card_detail_school_fee_history_payment.dart';

class TabViewSchoolFeeHistoryPayment extends StatefulWidget {
  const TabViewSchoolFeeHistoryPayment({super.key});

  @override
  State<TabViewSchoolFeeHistoryPayment> createState() =>
      _TabViewSchoolFeeHistoryPayment();
}

class _TabViewSchoolFeeHistoryPayment
    extends State<TabViewSchoolFeeHistoryPayment> {
  List<bool> listIsShowDetail = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolFeeBloc>.value(
      value: context.read<SchoolFeeBloc>(),
      child: BlocConsumer<SchoolFeeBloc, SchoolFeeState>(
        listener: (context, state) {
          if (state.schoolFeeHistoryStatus == SchoolFeeHistoryStatus.loaded) {
            listIsShowDetail = List.generate(
              state.historySchoolFee?.historySchoolFeeItems?.length ?? 3,
              (index) => false,
            );
          }
        },
        builder: (context, state) {
          if (state.schoolFeeHistoryStatus == SchoolFeeHistoryStatus.loaded) {
            final listData = state.historySchoolFee?.historySchoolFeeItems;
            if (listIsShowDetail.length != listData?.length) {
              listIsShowDetail = List.filled(listData?.length ?? 0, false);
            }
            return Scaffold(
              backgroundColor: AppColors.white,
              body: CustomRefresh(
                onRefresh: () async {
                  context
                      .read<SchoolFeeBloc>()
                      .add(const FetchSchoolFeeHistory());
                },
                child: isNullOrEmpty(listData)
                    ? const Center(
                        child: Text('Không có dữ liệu'),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return _buildHistoryPaymentCard(
                              context, listData ?? [], index);
                        },
                        itemCount: listData?.length ?? 0,
                      ),
              ),
            );
          } else {
            return Scaffold(
              body: CustomRefresh(
                onRefresh: () async {
                  context
                      .read<SchoolFeeBloc>()
                      .add(const FetchSchoolFeeHistory());
                },
                child: const Center(
                  child: Text('Có lỗi xảy ra'),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryPaymentCard(BuildContext context,
      List<HistorySchoolFeeItem> historySchoolFeeItems, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index < listIsShowDetail.length) {
            listIsShowDetail[index] = !listIsShowDetail[index];
          }
        });
      },
      child: CardDetailSchoolFeeHistoryPayment(
        item: historySchoolFeeItems[index],
        isShowDetail:
            listIsShowDetail.length > index ? listIsShowDetail[index] : false,
      ),
    );
  }
}
