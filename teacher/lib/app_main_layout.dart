import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/custom_loading_logo.dart';
import 'package:teacher/components/home_shadow_box.dart';
import 'package:teacher/screens/attendance/view/attendance_navigator.dart';
import 'package:teacher/screens/home/home_navigator.dart';
import 'package:teacher/screens/notifications/create/noti_create_screen.dart';
import 'package:teacher/screens/notifications/notifications_screen.dart';
import 'package:teacher/screens/schedule/schedule_screen.dart';
import 'package:teacher/screens/week_schedule/week_schedule_screen.dart';

class AppMainLayout extends StatefulWidget {
  const AppMainLayout({
    super.key,
    this.initIndex = 0,
  });

  final int initIndex;

  @override
  State<AppMainLayout> createState() => _AppMainLayoutState();
}

class _AppMainLayoutState extends State<AppMainLayout>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController tabBarController;

  final List<Widget> widgetOptionKinderGarten = [
    const HomeNavigator(),
    // const NotiCreateNew(),
    const WeekScheduleScreen(),
    const AttendanceNavigator(),
    const NotificationsScreen(),
  ];

  final List<Widget> widgetOptions = <Widget>[
    const HomeNavigator(),
    const ScheduleScreen(),
    const AttendanceNavigator(),
    const NotificationsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initIndex;
    tabBarController = TabController(
      length: 4,
      vsync: this,
    );
  }

  Future<void> _onItemTapped(int index) async {
    if (index == 0 &&
        index == _selectedIndex &&
        homeNavigatorKey.currentContext != null) {
      if (Navigator.canPop(homeNavigatorKey.currentContext!)) {
        homeNavigatorKey.currentContext?.pop();
      }
    }

    // TODO: improve this can not find HomeProvider to handle refresh
    // if (index == 0 && _selectedIndex == 0) {
    //   final homeBloc = homeNavigatorKey.currentContext?.read<HomeBloc>();
    //   homeBloc?.add(HomeRefresh());
    // }

    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: AppColors.gray100.withOpacity(0.7),
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: LoadingWithBrand(),
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_selectedIndex != 0) {
            tabBarController.animateTo(0);
            setState(() {
              _selectedIndex = 0;
            });
          }

          if (_selectedIndex == 0 && homeNavigatorKey.currentContext != null) {
            if (Navigator.canPop(homeNavigatorKey.currentContext!)) {
              homeNavigatorKey.currentContext?.pop();
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              return TabBarView(
                controller: tabBarController,
                physics: const NeverScrollableScrollPhysics(),
                children: state.user.isKinderGarten
                    ? widgetOptionKinderGarten
                    : widgetOptions,
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              return Container(
                height: 82.v,
                decoration: BoxDecoration(
                    color: AppColors.white, boxShadow: [homeBoxShadow()]),
                child: TabBar(
                  controller: tabBarController,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColors.brand500,
                  unselectedLabelColor: AppColors.gray400,
                  indicator: const BoxDecoration(),
                  labelStyle: AppTextStyles.semiBold12(),
                  tabs: [
                    Tab(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 0
                              ? AppColors.brand500
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      iconMargin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                      text: 'Trang chủ',
                    ),
                    state.user.isKinderGarten
                        ? Tab(
                            icon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.brand500
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconMargin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            text: 'Kế hoạch tuần',
                          )
                        : Tab(
                            icon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.brand500
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconMargin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            text: 'Thời khóa biểu',
                          ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 12.h),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/check.svg',
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 2
                                    ? AppColors.brand500
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Điểm danh',
                              style: AppTextStyles.semiBold12(
                                color: _selectedIndex == 2
                                    ? AppColors.brand500
                                    : AppColors.gray400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        'assets/icons/noti.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 3
                              ? AppColors.brand500
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      iconMargin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                      text: 'Thông báo',
                    ),
                  ],
                  onTap: (index) async {
                    _onItemTapped(index);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
