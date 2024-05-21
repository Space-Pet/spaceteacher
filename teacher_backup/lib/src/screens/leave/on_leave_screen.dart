import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/components/empty_screen.dart';
import 'package:teacher/model/leave_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/leave_repository/leave_repository.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/leave/bloc/leave_bloc.dart';
import 'package:teacher/src/screens/leave/history_leave_screen.dart';
import 'package:teacher/src/screens/leave/widget/application_item.dart';
import 'package:teacher/src/utils/extension_context.dart';

class OnLeaveScreen extends StatelessWidget {
  const OnLeaveScreen({super.key, required this.userInfo});
  static const routeName = '/on-leave';
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    final leaveRepository = Injection.get<LeaveRepository>();

    final leaveBloc = LeaveBloc(leaveRepositoryl: leaveRepository);
    leaveBloc.add(GetLeaves(userInfo: userInfo));
    return BlocProvider.value(
      value: leaveBloc,
      child: OnLeaveView(
        userInfo: userInfo,
      ),
    );
  }
}

class OnLeaveView extends StatefulWidget {
  const OnLeaveView({super.key, required this.userInfo});
  final UserInfo userInfo;
  @override
  State<OnLeaveView> createState() => _OnLeaveViewState();
}

class _OnLeaveViewState extends State<OnLeaveView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      final isLoading = state.leaveStatus == LeaveStatus.init;
      final leave = state.leaveData;

      late List<LeaveModel> approved = [];
      late List<LeaveModel> pending = [];
      for (final item in leave ?? []) {
        if (item.status.value == 'approved') {
          approved.add(item);
        } else {
          pending.add(item);
        }
      }
      return Scaffold(
        body: BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: 'Quản lý đơn',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
                hasUpdateYear: true,
                icon: Assets.icons.leaveAttendance.path,
                onOpenIcon: () {
                  context.push(HistoryLeaveScreen.routeName,
                      arguments: {'userInfo': widget.userInfo});
                },
              ),
              const SizedBox(height: 6),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppColors.brand600,
                            dividerColor: Colors.transparent,
                            labelPadding: EdgeInsets.zero,
                            indicatorPadding: const EdgeInsets.only(top: -3.5),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: AppTextStyles.semiBold16(
                              color: AppColors.brand600,
                            ),
                            onTap: (value) {
                              setState(() {
                                _tabController.index = value;
                              });
                            },
                            unselectedLabelStyle: AppTextStyles.semiBold14(
                                color: AppColors.brand600),
                            indicator: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            tabs: const [
                              Tab(
                                child: Align(
                                  child: Text(
                                    'Chưa duyệt',
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  child: Text('Đã duyệt'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          skeleton: Container(
                              color: Colors.white,
                              height: double.infinity,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                itemCount: 5,
                                itemBuilder: (context, index) => Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: index == 4
                                          ? BorderSide.none
                                          : const BorderSide(
                                              color: AppColors.gray300),
                                    ),
                                  ),
                                  child: SkeletonItem(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                  lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 10,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              )),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (pending.isNotEmpty)
                                            Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  itemCount: pending.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item = pending[index];

                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          top: index == 0
                                                              ? 0
                                                              : 8),
                                                      child: ApplicationItem(
                                                        application: item,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          if (pending.isEmpty)
                                            const EmptyScreen(
                                                text:
                                                    'Bạn không có nghỉ phép chưa duyệt'),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (approved.isEmpty)
                                            const EmptyScreen(
                                                text:
                                                    'Bạn không có nghỉ phép đã duyệt'),
                                          if (approved.isNotEmpty)
                                            Expanded(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  itemCount: approved.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final item =
                                                        approved[index];
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          top: index == 0
                                                              ? 0
                                                              : 8),
                                                      child: ApplicationItem(
                                                        application: item,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SafeArea(
                                  child: RoundedButton(
                                    onTap: () {
                                      // context.push(LeaveApplicationScreen(
                                      //   onOk: () {
                                      //     context
                                      //         .read<LeaveBloc>()
                                      //         .add(GetLeaves(page: 1));
                                      //   },
                                      // ));
                                    },
                                    borderRadius: 70,
                                    buttonColor: AppColors.primaryRedColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Xin nghỉ phép',
                                      style: AppTextStyles.semiBold16(
                                          color: AppColors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
