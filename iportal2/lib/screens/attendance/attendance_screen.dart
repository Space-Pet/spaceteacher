import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_attendance.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_day.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_view_days.dart';
import 'package:repository/repository.dart';

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
    final attendanceBloc = AttendanceBloc(
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: context.read<UserRepository>(),
    );

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
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenAppBar(title: 'Xem điểm danh'),
          Expanded(
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
              final attendanceBloc = context.read<AttendanceBloc>();
              final attendanceDay = state.attendanceday;
              final attendanceWeek = state.attendanceWeek;
              final attendanceMonth = state.attendanceMonth;
              final selectDate = state.selectDate;
              final isLoading =
                  (state.attendanceStatus == AttendanceStatus.init);
              final type = state.type;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: (type == null || type == '')
                    ? const Center(child: EmptyScreen(text: 'Không có dữ liệu'))
                    : AppSkeleton(
                        isLoading: isLoading,
                        child: CTabBarAttendance(
                          attendanceBloc: attendanceBloc,
                          stateAttendance: attendanceDay,
                          attendanceWeek: attendanceWeek,
                          attendanceMonth: attendanceMonth,
                          selectDate: selectDate,
                          cTabBarViewDay: TabBarViewDay(
                            selectDate: selectDate,
                            lessons: attendanceDay,
                            getAttendanceDay: (formattedDate, date) {
                              attendanceBloc.add(
                                GetAttendanceDay(
                                  date: formattedDate,
                                  selectDate: date,
                                ),
                              );
                            },
                          ),
                          cTabBarViewWeek: TabBarViewDays(
                            selectDate: selectDate,
                            attendanceWeek: attendanceWeek,
                            getAttendanceWeek: (endDate, startDate) {
                              attendanceBloc.add(
                                GetAttendanceWeek(
                                  endDate: endDate,
                                  startDate: startDate,
                                ),
                              );
                            },
                          ),
                          cTabBarViewMonth: TabBarViewDays(
                            attendanceWeek: attendanceMonth,
                            isWeek: false,
                            selectDate: selectDate,
                            getAttendanceMonth: (endDate, startDate) {
                              attendanceBloc.add(
                                GetAttendanceMonth(
                                  endDate: endDate,
                                  startDate: startDate,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
