import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_status.dart';

import 'card_fee_detail_requested/w_card_topic_fee_detail_requested.dart';

class TabBarViewRequested extends StatefulWidget {
  const TabBarViewRequested({
    super.key,
  });

  @override
  State<TabBarViewRequested> createState() => _TabBarViewRequested();
}

class _TabBarViewRequested extends State<TabBarViewRequested> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeePlanBloc, FeePlanState>(
      builder: (context, state) {
        final it = state.studentFeesRequestedData?.data;
        if (state.historyStatus == FeePlanHistoryStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.historyStatus == FeePlanHistoryStatus.loaded) {
          if (isNullOrEmpty(state.studentFeesRequestedData?.data)) {
            return const Center(
              child: Text('Không có dữ liệu'),
            );
          } else {
            return CustomRefresh(
              onRefresh: () async {
                context.read<FeePlanBloc>().add(
                      GetFeeRequested(
                        learnYear: state.currentYearState?.learnYear,
                      ),
                    );
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!isNullOrEmpty(it?.sp1_001))
                      CardTopicFeeDetailRequested(
                          titleTopic: "Học phí",
                          feeCategoryData: it?.sp1_001?.data),
                    if (!isNullOrEmpty(it?.sp1_002))
                      CardTopicFeeDetailRequested(
                          titleTopic: "Phí bán trú",
                          feeCategoryData: it?.sp1_002?.data),
                    if (!isNullOrEmpty(it?.sp1_003))
                      CardTopicFeeDetailRequested(
                          titleTopic: "Phí nội trú",
                          feeCategoryData: it?.sp1_003?.data),
                    if (!isNullOrEmpty(it?.sp1_004))
                      CardTopicFeeDetailRequested(
                          titleTopic: "Dịch vụ giáo dục",
                          feeCategoryData: it?.sp1_004?.data),
                    if (!isNullOrEmpty(it?.sp1_005))
                      CardTopicFeeDetailRequested(
                          titleTopic: "Lệ phí",
                          feeCategoryData: it?.sp1_005?.data),
                  ],
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}
