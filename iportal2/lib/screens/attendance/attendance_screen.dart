import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

import 'widget/tab_bar_attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    DateFormat formatDate = DateFormat("yyyy-MM-dd");
    DateTime currentDate = DateTime.now();
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month);
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final attendanceBloc = AttendanceBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);

    attendanceBloc.add(GetAttendanceDay(
        date: formatDate.format(DateTime.now()), selectDate: DateTime.now()));
    attendanceBloc.add(GetAttendanceWeek(
        endDate: formatDate.format(lastDayOfWeek),
        startDate: formatDate.format(firstDayOfWeek)));
    attendanceBloc.add(GetAttendanceMonth(
        endDate: formatDate.format(lastDayOfMonth),
        startDate: formatDate.format(firstDayOfMonth)));

    return BlocProvider.value(
      value: attendanceBloc,
      child: const AttendanceView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final desiredHeight = screenHeight * 1;
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenAppBar(
            title: 'Xem điểm danh',
          ),
          BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
            final attendanceDay = state.attendanceday;
            final attendanceWeek = state.attendanceWeek;
            final attendanceMonth = state.attendanceMonth;
            final selectDate = state.selectDate;
            final isLoading = state.attendanceStatus == AttendanceStatus.init;
            return Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: AppSkeleton(
                  skeleton: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: index == 4
                                  ? BorderSide.none
                                  : const BorderSide(color: AppColors.gray300),
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
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                        ),
                      )),
                  isLoading: isLoading,
                  child: CustomRefresh(
                    onRefresh: () async {
                      DateFormat formatDate = DateFormat("yyyy-MM-dd");
                      DateTime currentDate = DateTime.now();
                      DateTime firstDayOfWeek = currentDate
                          .subtract(Duration(days: currentDate.weekday - 1));
                      DateTime lastDayOfWeek =
                          firstDayOfWeek.add(Duration(days: 6));
                      DateTime firstDayOfMonth =
                          DateTime(currentDate.year, currentDate.month, 1);
                      DateTime lastDayOfMonth =
                          DateTime(currentDate.year, currentDate.month + 1, 0);

                      final userRepository = context.read<UserRepository>();
                      final appFetchApiRepository =
                          context.read<AppFetchApiRepository>();
                      final attendanceBloc = AttendanceBloc(
                          appFetchApiRepo: appFetchApiRepository,
                          currentUserBloc: context.read<CurrentUserBloc>(),
                          userRepository: userRepository);

                      attendanceBloc.add(GetAttendanceDay(
                          date: formatDate.format(DateTime.now()),
                          selectDate: DateTime.now()));
                      attendanceBloc.add(GetAttendanceWeek(
                          endDate: formatDate.format(lastDayOfWeek),
                          startDate: formatDate.format(firstDayOfWeek)));
                      attendanceBloc.add(GetAttendanceMonth(
                          endDate: formatDate.format(lastDayOfMonth),
                          startDate: formatDate.format(firstDayOfMonth)));
                    },
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            height: desiredHeight,
                            width: double.infinity,
                            child: Column(
                              children: [
                                TabBarAttendance(
                                  selectDate: selectDate,
                                  stateAttendance: attendanceDay,
                                  attendanceWeek: attendanceWeek,
                                  attendanceMonth: attendanceMonth,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
