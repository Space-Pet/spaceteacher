import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/screens/leave/bloc/leave_bloc.dart';
import 'package:iportal2/screens/leave/leave_application_screen.dart';
import 'package:iportal2/screens/leave/widget/application_item.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

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
    leaveBloc.add(GetLeaves());
    return BlocProvider.value(
      value: leaveBloc,
      child: OnLeaveView(),
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
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      if (state.leaveStatus == LeaveStatus.init) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final leave = state.leaveData;
        final List<LeaveData> approved = [];
        final List<LeaveData> pending = [];
        for (final item in leave ?? []) {
          if (item.value == 'approved') {
            approved.add(item);
          } else {
            pending.add(item);
          }
        }
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
                            tabs: [
                              Tab(
                                child: Align(
                                  child: Text(
                                    'Chưa duyệt (${pendingApplication.length})',
                                  ),
                                ),
                              ),
                              const Tab(
                                child: Align(
                                  child: Text('Đã duyệt'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
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
                                    ListView.builder(
                                        padding: const EdgeInsets.only(top: 8),
                                        itemCount: pending.length,
                                        itemBuilder: (context, index) {
                                          final item = pending[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: index == 0 ? 0 : 8),
                                            child: ApplicationItem(
                                              application: item,
                                            ),
                                          );
                                        }),
                                    ListView.builder(
                                        padding: const EdgeInsets.only(top: 8),
                                        itemCount: approved.length,
                                        itemBuilder: (context, index) {
                                          final item = approved[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: index == 0 ? 0 : 8),
                                            child: ApplicationItem(
                                              application: item,
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SafeArea(
                                child: RoundedButton(
                                  onTap: () {
                                    context
                                        .push(const LeaveApplicationScreen());
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
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }
}

enum ApplicationStatus {
  pending,
  approved,
  rejected,
}

extension ApplicationStatusX on ApplicationStatus {
  bool get isPending => this == ApplicationStatus.pending;
  bool get isApproved => this == ApplicationStatus.approved;

  String getName() {
    if (isPending) return 'Chờ duyệt';
    return 'Đã duyệt';
  }
}

class LeaveApplicationModel {
  const LeaveApplicationModel({
    required this.id,
    required this.title,
    required this.status,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.endDate,
    required this.reason,
    required this.approver,
    required this.isFullday,
  });

  final int id;
  final String title;
  final ApplicationStatus status;
  final DateTime? startTime;
  final DateTime startDate;
  final DateTime? endTime;
  final DateTime endDate;
  final String reason;
  final String approver;
  final bool isFullday;
}

List<LeaveApplicationModel> applications = [
  LeaveApplicationModel(
    id: 1,
    title: 'Đơn xin nghỉ',
    status: ApplicationStatus.pending,
    startDate: DateTime.now(),
    startTime: null,
    endDate: DateTime.now(),
    endTime: null,
    reason: 'Xin nghỉ ốm',
    approver: 'Nguyễn Minh Nhi',
    isFullday: true,
  ),
  LeaveApplicationModel(
    id: 4,
    title: 'Đơn xin nghỉ',
    status: ApplicationStatus.pending,
    startDate: DateTime.now(),
    startTime: null,
    endDate: DateTime.now(),
    endTime: null,
    reason: 'Xin nghỉ ốm',
    approver: 'Nguyễn Minh Nhi',
    isFullday: true,
  ),
  LeaveApplicationModel(
    id: 1,
    title: 'Đơn xin nghỉ',
    status: ApplicationStatus.pending,
    startDate: DateTime.now(),
    startTime: null,
    endDate: DateTime.now(),
    endTime: null,
    reason: 'Xin nghỉ ốm',
    approver: 'Nguyễn Minh Nhi',
    isFullday: true,
  ),
  LeaveApplicationModel(
    id: 2,
    title: 'Đơn xin nghỉ 2',
    status: ApplicationStatus.approved,
    startDate: DateTime.now(),
    startTime: DateTime.now(),
    endDate: DateTime.now(),
    endTime: DateTime.now(),
    reason: 'Xin nghỉ ốm',
    approver: 'Nguyễn Minh Nhi',
    isFullday: false,
  ),
  LeaveApplicationModel(
    id: 3,
    title: 'Đơn xin nghỉ 3',
    status: ApplicationStatus.approved,
    startDate: DateTime.now(),
    startTime: DateTime.now(),
    endDate: DateTime.now(),
    endTime: DateTime.now(),
    reason: 'Xin nghỉ ốm',
    approver: 'Nguyễn Minh Nhi',
    isFullday: false,
  ),
];

final List<LeaveApplicationModel> pendingApplication = [
  ...applications.where((e) => e.status.isPending)
];

final List<LeaveApplicationModel> approvedAppliction = [
  ...applications.where((e) => e.status.isApproved)
];
