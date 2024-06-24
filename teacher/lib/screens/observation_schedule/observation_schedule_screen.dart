import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_bloc.dart';
import 'package:teacher/screens/observation_schedule/views/register_view.dart';
import 'package:teacher/screens/observation_schedule/views/registered_view.dart';

class ObservationSchedule extends StatelessWidget {
  const ObservationSchedule({super.key});
  static const routeName = '/observation_schedule';

  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>().state.user;

    return BlocProvider(
      create: (context) => ObservationBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        userKey: currentUserBloc.user_key,
        schoolId: currentUserBloc.school_id,
      ),
      child: const ObservationScheduleView(),
    );
  }
}

class ObservationScheduleView extends StatefulWidget {
  const ObservationScheduleView({super.key});

  @override
  State<ObservationScheduleView> createState() =>
      _ObservationScheduleViewState();
}

class _ObservationScheduleViewState extends State<ObservationScheduleView>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ['Đăng ký dự giờ', 'Các tiết đã đăng ký'];
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      length: 2,
      vsync: this,
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        height: 40,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        children: [
          ScreenAppBar(
            title: 'Lịch dự giờ',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          DefaultTabController(
            length: tabs.length,
            child: TabBar(
              padding: const EdgeInsets.all(0),
              labelPadding: EdgeInsets.zero,
              labelColor: AppColors.brand600,
              tabAlignment: TabAlignment.fill,
              unselectedLabelColor: AppColors.white,
              dividerColor: AppColors.white,
              labelStyle: AppTextStyles.semiBold16(color: AppColors.brand600),
              unselectedLabelStyle:
                  AppTextStyles.semiBold16(color: AppColors.gray500),
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: AppColors.white,
              ),
              tabs: _buildTabs(),
              onTap: (value) {
                tabBarController.animateTo(value);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabBarController,
              children: const [RegisterView(), RegisteredView()],
            ),
          ),
        ],
      ),
    );
  }
}
