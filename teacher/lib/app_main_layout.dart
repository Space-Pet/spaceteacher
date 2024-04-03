import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:teacher/common_bloc/user_manager/bloc/user_manager_bloc.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';

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
    // const WeekScheduleScreen(),
    // const AttendanceScreen(),
    // const NotificationsScreen(),
    // const MenuScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    // const ScheduleScreen(),
    // const AttendanceScreen(),
    // const NotificationsScreen(),
    // const MenuScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
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
                  labelStyle: AppTextStyles.normal12(),
                  tabs: [
                    Tab(
                      height: 92.v,
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 0
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: 'Trang chủ',
                    ),
                    state.userInfo.isKinderGarten()
                        ? Tab(
                            icon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: 'Dự án tuần',
                          )
                        : Tab(
                            icon: SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              colorFilter: ColorFilter.mode(
                                _selectedIndex == 1
                                    ? AppColors.red
                                    : AppColors.gray400,
                                BlendMode.srcIn,
                              ),
                            ),
                            text: 'Thời khóa biểu',
                          ),
                    Tab(
                      icon: SvgPicture.asset(
                        'assets/icons/check.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 2
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: 'Điểm danh',
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        'assets/icons/noti.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 3
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: 'Thông báo',
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 4
                              ? AppColors.red
                              : AppColors.gray400,
                          BlendMode.srcIn,
                        ),
                      ),
                      text: 'Thực đơn',
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
