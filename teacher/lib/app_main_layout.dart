import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:teacher/common_bloc/user_manager/bloc/user_manager_bloc.dart';

import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/i18n/locale_keys.g.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/attendance/attendance_screen.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
import 'package:teacher/src/screens/menu/menu_screen.dart';
import 'package:teacher/src/screens/notifications/view/notifications_screen.dart';
import 'package:teacher/src/screens/schedule/schedule_screen.dart';
import 'package:teacher/src/screens/week_schedule/week_schedule_screen.dart';

class AppMainLayout extends StatefulWidget {
  static const String routeName = '/';
  const AppMainLayout({
    super.key,
    this.initIndex = 0,
  });

  final int initIndex;

  @override
  State<AppMainLayout> createState() => _AppMainLayoutState();
}

class _AppMainLayoutState extends State<AppMainLayout> {
  int _selectedIndex = 0;
  final bloc = UserManagerBloc(userRepository: Injection.get<UserRepository>());
  final List<Widget> widgetOptionKinderGarten = [
    const HomeScreen(),
    const WeekScheduleScreen(),
    const AttendanceScreen(),
    const NotificationsScreen(),
    const MenuScreen(),
  ];

  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const ScheduleScreen(),
    const AttendanceScreen(),
    const NotificationsScreen(),
    const MenuScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initIndex;
  }

  Future<void> _onItemTapped(int index) async {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<UserManagerBloc, UserManagerState>(
          bloc: bloc,
          builder: (context, state) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: state.userInfo.isKinderGarten()
                  ? widgetOptionKinderGarten
                  : widgetOptions,
            );
          },
        ),
        bottomNavigationBar: ClipRRect(
          child: BlocBuilder<UserManagerBloc, UserManagerState>(
            bloc: bloc,
            builder: (context, state) {
              return Container(
                decoration: const BoxDecoration(color: AppColors.white),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColors.red,
                  indicator: const BoxDecoration(),
                  labelStyle: AppTextStyles.normal10(),
                  tabs: [
                    Tab(
                      height: 92.v,
                      icon: Assets.icons.home.svg(
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 0
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: LocaleKeys.home.tr(),
                    ),
                    state.userInfo.isKinderGarten()
                        ? Tab(
                            icon: Assets.icons.calendar.svg(
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: LocaleKeys.weeklyProject.tr(),
                          )
                        : Tab(
                            icon: Assets.icons.features.highSScores.svg(
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: LocaleKeys.checkGrades.tr(),
                          ),
                    state.userInfo.isKinderGarten()
                        ? Tab(
                            icon: Assets.icons.features.highSBus.svg(
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 2
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: LocaleKeys.weeklyProject.tr(),
                          )
                        : Tab(
                            icon: Assets.icons.features.highSAttendance.svg(
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 2
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: LocaleKeys.attendance.tr(),
                          ),
                    Tab(
                      icon: Assets.icons.noti.svg(
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 3
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: 'noti'.tr(),
                    ),
                    Tab(
                      icon: Assets.icons.features.moreCircle.svg(
                        width: 28,
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 4
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: LocaleKeys.all.tr(),
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
