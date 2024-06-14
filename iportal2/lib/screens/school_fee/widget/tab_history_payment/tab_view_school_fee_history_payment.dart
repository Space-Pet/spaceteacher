import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
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
          if (state.schoolFeeHistoryStatus == SchoolFeeHistoryStatus.loading) {
            return Scaffold(
              body: Skeletonizer(
                enabled: true,
                child: CustomRefresh(
                  onRefresh: () async {
                    context
                        .read<SchoolFeeBloc>()
                        .add(const FetchSchoolFeeHistory());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        5,
                        (index) =>
                            _buildHistoryPaymentCard(context, state, index),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state.schoolFeeHistoryStatus ==
              SchoolFeeHistoryStatus.loaded) {
            final itemsLength =
                state.historySchoolFee?.historySchoolFeeItems?.length ?? 0;
            if (listIsShowDetail.length != itemsLength) {
              listIsShowDetail = List.filled(itemsLength, false);
            }
            return Scaffold(
              body: Skeletonizer(
                enabled: false,
                child: CustomRefresh(
                  onRefresh: () async {
                    context
                        .read<SchoolFeeBloc>()
                        .add(const FetchSchoolFeeHistory());
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        itemsLength,
                        (index) =>
                            _buildHistoryPaymentCard(context, state, index),
                      ),
                    ),
                  ),
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

  Widget _buildHistoryPaymentCard(
      BuildContext context, SchoolFeeState state, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index < listIsShowDetail.length) {
            listIsShowDetail[index] = !listIsShowDetail[index];
          }
        });
      },
      child: CardDetailSchoolFeeHistoryPayment(
        item: state.historySchoolFee?.historySchoolFeeItems?[index] ??
            HistorySchoolFeeItem(),
        isShowDetail:
            listIsShowDetail.length > index ? listIsShowDetail[index] : false,
      ),
    );
  }
}
