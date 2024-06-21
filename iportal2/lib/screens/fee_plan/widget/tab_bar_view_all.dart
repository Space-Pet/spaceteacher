import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_status.dart';
import 'package:iportal2/screens/fee_plan/widget/dialog_tab_fee_plan.dart';

import 'card_fee_detail/w_card_topic_fee_detail.dart';

class TabBarViewAll extends StatefulWidget {
  const TabBarViewAll({
    super.key,
  });

  @override
  State<TabBarViewAll> createState() => _TabBarViewAll();
}

class _TabBarViewAll extends State<TabBarViewAll> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FeePlanBloc>(),
      child: BlocConsumer<FeePlanBloc, FeePlanState>(
        listener: (context, state) {
          if (state.sendRequestStatus == FeePlanSendRequestStatus.loaded) {
            LoadingDialog.hide(context);
            context.read<FeePlanBloc>().add(
                  const UpdateStatusFeePlan(
                    sendRequestStatus: FeePlanSendRequestStatus.initial,
                  ),
                );
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FeePlanDialogNoti(
                    isSuccess:
                        state.sendRequestStatusText == "success" ? true : false,
                  );
                }).then((value) {
              if (value['refresh'] == true && value['tabIndex'] != null) {
                context.read<FeePlanBloc>().add(
                      const UpdateCurrentTabIndex(currentTabIndex: 1),
                    );
                context.read<FeePlanBloc>().add(GetFeeRequested(
                    learnYear: state.currentYearState?.learnYear));
                context.read<FeePlanBloc>().add(
                    GetListFee(learnYear: state.currentYearState?.learnYear));
              } else {
                context.read<FeePlanBloc>().add(
                      const UpdateCurrentTabIndex(currentTabIndex: 0),
                    );
                context.read<FeePlanBloc>().add(
                    GetListFee(learnYear: state.currentYearState?.learnYear));
                context.read<FeePlanBloc>().add(GetFeeRequested(
                    learnYear: state.currentYearState?.learnYear));
              }
            });
          } else if (state.sendRequestStatus ==
              FeePlanSendRequestStatus.loading) {
            LoadingDialog.show(context);
          }
        },
        builder: (context, state) {
          final it = state.studentFeesData?.data;
          if (state.status == FeePlanStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == FeePlanStatus.loaded) {
            return Stack(
              children: [
                CustomRefresh(
                  onRefresh: () async {
                    context.read<FeePlanBloc>().add(
                          GetListFee(
                            learnYear: state.currentYearState?.learnYear,
                          ),
                        );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (!isNullOrEmpty(it?.sp1_001))
                          CardTopicDetailFeePlan(
                              titleTopic: "Học phí",
                              feeCategoryData:
                                  it?.sp1_001?.data ?? FeeCategoryData()),
                        if (!isNullOrEmpty(it?.sp1_002))
                          CardTopicDetailFeePlan(
                              titleTopic: "Phí bán trú",
                              feeCategoryData:
                                  it?.sp1_002?.data ?? FeeCategoryData()),
                        if (!isNullOrEmpty(it?.sp1_003))
                          CardTopicDetailFeePlan(
                              titleTopic: "Phí nội trú",
                              feeCategoryData:
                                  it?.sp1_003?.data ?? FeeCategoryData()),
                        if (!isNullOrEmpty(it?.sp1_004))
                          CardTopicDetailFeePlan(
                              titleTopic: "Dịch vụ giáo dục",
                              feeCategoryData:
                                  it?.sp1_004?.data ?? FeeCategoryData()),
                        if (!isNullOrEmpty(it?.sp1_005))
                          CardTopicDetailFeePlan(
                              titleTopic: "Lệ phí",
                              feeCategoryData:
                                  it?.sp1_005?.data ?? FeeCategoryData()),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 44,
                    child: RoundedButton(
                      onTap: () {
                        context.read<FeePlanBloc>().add(
                              SendFeeRequested(
                                listItemFee: state.listVerify ?? [],
                              ),
                            );
                      },
                      borderRadius: 70,
                      padding: EdgeInsets.zero,
                      buttonColor: AppColors.red90001,
                      child: Text(
                        'Xác nhận biểu phí',
                        style: AppTextStyles.semiBold16(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.status == FeePlanStatus.error) {
            return Center(
              child: Text(state.errorsText ?? ""),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
