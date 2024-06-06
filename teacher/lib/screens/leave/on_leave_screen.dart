import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/buttons.dart';
import 'package:teacher/components/dialog/dialog_leave_info.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/leave/bloc/leave_bloc.dart';

class OnLeaveScreen extends StatelessWidget {
  const OnLeaveScreen({super.key});
  static const routeName = '/on-leave';

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final leaveBloc = LeaveBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);

    return BlocProvider.value(
      value: leaveBloc,
      child: const OnLeaveView(),
    );
  }
}

class OnLeaveView extends StatefulWidget {
  const OnLeaveView({super.key});

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
    return BlocConsumer<LeaveBloc, LeaveState>(listener: (context, state) {
      final status = state.leaveStatus;
      if (status == LeaveTeacherStatus.approveAllSuccess ||
          status == LeaveTeacherStatus.approveSuccess) {
        SnackBarUtils.showFloatingSnackBar(context, 'Duyệt tất cả thành công!');
      }
      if (status == LeaveTeacherStatus.error) {
        SnackBarUtils.showFloatingSnackBar(
            context, state.message ?? 'Có lỗi xảy ra, vui lỏng thử lại!');
      }
    }, builder: (context, state) {
      final leaveBloc = context.read<LeaveBloc>();
      final isLoading = state.leaveStatus == LeaveTeacherStatus.loading;
      final leaveData = state.leaveData;
      final leaveApproved = state.leaveApproved;

      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              title: 'Nghỉ phép',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            const SizedBox(height: 6),
            Flexible(
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
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: AppColors.brand600,
                          dividerColor: Colors.transparent,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: const EdgeInsets.only(top: -5.5),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: AppTextStyles.semiBold16(
                            color: AppColors.brand600,
                          ),
                          onTap: (value) {
                            setState(() {
                              _tabController.index = value;
                            });

                            leaveBloc.add(LeaveFilter(
                                newStatus: value == 0
                                    ? LeaveStatusValue.pending
                                    : LeaveStatusValue.approved));
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
                              child: Text(
                                'Chưa duyệt',
                              ),
                            ),
                            Tab(
                              child: Text('Đã duyệt'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            16, _tabController.index == 1 ? 12 : 0, 16, 0),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: AppSkeleton(
                          isLoading: isLoading,
                          // skeleton: const LeaveSkeleton(),
                          child: Column(
                            children: [
                              if (_tabController.index == 1)
                                SelectDate(
                                  datePicked: state.datePicked,
                                  onDatePicked: (date) {
                                    leaveBloc
                                        .add(LeaveSelectDate(datePicked: date));
                                  },
                                ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        leaveData.isEmpty
                                            ? const EmptyScreen(
                                                text:
                                                    'Chưa có nghỉ phép chờ duyệt')
                                            : Expanded(
                                                child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    itemCount: leaveData.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item =
                                                          leaveData[index];

                                                      return InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                LeaveInfoDialog(
                                                              bloc: leaveBloc,
                                                              leaveInfo: item,
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      index == 0
                                                                          ? 0
                                                                          : 8),
                                                          child:
                                                              ApplicationItem(
                                                            application: item,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        leaveApproved.isEmpty
                                            ? const EmptyScreen(
                                                text:
                                                    'Chưa có đơn nghỉ phép đã duyệt')
                                            : Expanded(
                                                child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    itemCount:
                                                        leaveApproved.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final item =
                                                          leaveApproved[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled:
                                                                true,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                LeaveInfoDialog(
                                                              bloc: leaveBloc,
                                                              leaveInfo: item,
                                                              hasApproved: true,
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      index == 0
                                                                          ? 0
                                                                          : 8),
                                                          child:
                                                              ApplicationItem(
                                                            application: item,
                                                          ),
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
                              if (_tabController.index == 0 &&
                                  leaveData.isNotEmpty)
                                RoundedButton(
                                  onTap: () {
                                    leaveBloc.add(LeaveAprroveAll());
                                  },
                                  borderRadius: 70,
                                  buttonColor: AppColors.primaryRedColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    'Duyệt tất cả',
                                    style: AppTextStyles.semiBold16(
                                        color: AppColors.white),
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
      );
    });
  }
}

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({
    super.key,
    required this.application,
  });

  final LeaveTeacher application;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.gray100),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.blueGray100,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                Assets.icons.calendarLeave,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ApplicationHeader(
                  pupilName: application.pupilName,
                  status: application.status,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.gray500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('EEEE dd/MM/yyyy', 'vi_VN')
                          .format(application.startDate)
                          .toString(),
                      style: AppTextStyles.normal14(color: AppColors.gray600),
                    ),
                  ],
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  application.content,
                  style: AppTextStyles.normal14(color: AppColors.gray600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader(
      {super.key, required this.pupilName, required this.status});

  final LeaveStatus status;
  final String pupilName;

  @override
  Widget build(BuildContext context) {
    final isApproved = status.value.value == LeaveStatusValue.approved.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          pupilName,
          style: AppTextStyles.semiBold14(color: AppColors.gray800),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: isApproved ? AppColors.green100 : AppColors.warning100,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Text(
              status.text,
              style: AppTextStyles.normal12(
                color: isApproved ? AppColors.green700 : AppColors.warning500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
