import 'package:core/presentation/common_widget/date_picker/flutter_datetime_picker/src/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/select_child.dart';
import 'package:iportal2/screens/attendance/bloc/attendance_bloc.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_attendance.dart';
import 'package:repository/repository.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_decoration.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat("yyyy-MM-dd");
    DateTime currentDate = DateTime.now();
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final attendanceBloc = AttendanceBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);

    attendanceBloc
        .add(GetAttendanceDay(date: formatDate.format(DateTime.now())));
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
          const ScreenAppBar(
            title: 'Xem điểm danh',
          ),
          BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
            final attendanceDay = state.attendanceday;
            final attendanceWeek = state.attendanceWeek;
            final attendanceMonth = state.attendanceMonth;
            print('object: ${attendanceWeek?.absentData.items?.length}');
            return Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  children: [
                    const SelectChild(),
                    TabBarAttendance(
                      stateAttendance: attendanceDay,
                      attendanceWeek: attendanceWeek,
                      attendanceMonth: attendanceMonth,
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
