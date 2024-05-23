import 'dart:isolate';

import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/dialog/show_dialog.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_bloc.dart';

import 'package:iportal2/screens/fee_plan/widget/card_fee_detail/w_card_topic_fee_detal.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      child: BlocBuilder<FeePlanBloc, FeePlanState>(
        builder: (context, state) {
          final it = state.studentFeesData?.data;
          if (state.status == FeePlanStatus.error) {
            return Center(
              child: Text(state.errorsText ?? ""),
            );
          } else {
            return Stack(
              children: [
                CustomRefresh(
                  onRefresh: () async {
                    context.read<FeePlanBloc>().add(
                          const GetListFee(),
                        );
                  },
                  child: Skeletonizer(
                    enabled: state.status == FeePlanStatus.loading,
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 44,
                    child: RoundedButton(
                      onTap: () async {
                        context.read<FeePlanBloc>().add(
                              SendFeeRequested(
                                listItemFee: state.listVerify ?? [],
                              ),
                            );
                        if (state.status == FeePlanStatus.loaded) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ShowDialog(
                                  title: 'Đã gửi yêu cầu đến trường.',
                                  textConten:
                                      'Quý cha mẹ học sinh vui lòng chờ nhân viên trường kiểm tra và áp giảm giá (nếu có)',
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFFECFDF3),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xFFD1FADF),
                                      child: Icon(
                                        Icons.done,
                                        color: AppColors.green600,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else if (state.status == FeePlanStatus.error) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ShowDialog(
                                  title: 'Đã xảy ra lỗi.',
                                  textConten: 'Vui lòng thử lại sau.',
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFFFFF0F0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xFFFFD1D1),
                                      child: Icon(
                                        Icons.error,
                                        color: AppColors.red90001,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
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
          }
        },
      ),
    );
  }
}
