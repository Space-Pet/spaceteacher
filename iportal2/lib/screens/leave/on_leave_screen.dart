import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/screens/leave/bloc/leave_bloc.dart';
import 'package:iportal2/screens/leave/leave_application_screen.dart';
import 'package:iportal2/screens/leave/widget/application_item.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

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
    leaveBloc.add(GetLeaves(page: 1));
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
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollAtBottom()) {
      final leaveBloc = context.read<LeaveBloc>();
      if (leaveBloc.state.leaveStatus == LeaveStatus.success) {
        const currentPage = 1;
        leaveBloc.add(GetLeavesMore(page: currentPage + 1));
      }
    }
  }

  bool _isScrollAtBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      final isLoading = state.leaveStatus == LeaveStatus.init;
      final leave = state.leaveData;
      late List<LeaveData> approved = [];
      late List<LeaveData> pending = [];
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
                                    ListView.builder(
                                        controller: _scrollController,
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
                                        controller: _scrollController,
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
                              if (state.leaveStatus == LeaveStatus.loadMore)
                                const SizedBox(
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              const SizedBox(height: 10),
                              SafeArea(
                                child: RoundedButton(
                                  onTap: () {
                                    context.push(LeaveApplicationScreen(
                                      onOk: () {
                                        context
                                            .read<LeaveBloc>()
                                            .add(GetLeaves(page: 1));
                                      },
                                    ));
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
      );
    });
  }
}
