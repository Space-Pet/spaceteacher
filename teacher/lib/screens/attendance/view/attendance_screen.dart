import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/attendance/bloc/attendance_bloc.dart';
import 'package:teacher/screens/attendance/widget/attendance_teacher/attendance_teacher.dart';
import 'package:teacher/screens/attendance/widget/tab_bar_attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  static const routeName = '/attendance';

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    // with AutomaticKeepAliveClientMixin 
    {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final currentUserBloc = context.read<CurrentUserBloc>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final attendanceBloc = AttendanceBloc(
        appFetchApiRepository: appFetchApiRepository,
        currentUserBloc: currentUserBloc);

    return BlocProvider(
      create: (_) => attendanceBloc,
      child: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state.attendanceStatus == AttendanceStatus.failClass) {
            Fluttertoast.showToast(
                msg: 'Không lấy được danh sách lớp',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          }
        },
        builder: (context, state) {
          return AttendanceView(
              state: state,
              actions: (event) {
                attendanceBloc.add(event);
              });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ignore: must_be_immutable
class AttendanceView extends StatelessWidget {
  const AttendanceView({
    super.key,
    required this.state,
    required this.actions,
  });

  final AttendanceState state;
  final void Function(AttendanceEvent) actions;

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  DateTime findFirstDateOfTheWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime date) {
    int dayOfWeek = date.weekday;
    return date.add(Duration(days: DateTime.daysPerWeek - dayOfWeek));
  }

  DateTime findFirstDateOfTheMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  DateTime findLastDateOfTheMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    void showOptionsBottomSheet(
        BuildContext context, List<ClassTeacher>? classTeacher) {
      DateTime today = DateTime.now();
      String startDateWeek = formatDate(findFirstDateOfTheWeek(today));
      String endDateWeek = formatDate(findLastDateOfTheWeek(today));
      String startDateMonth = formatDate(findFirstDateOfTheMonth(today));
      String endDateMonth = formatDate(findLastDateOfTheMonth(today));

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Điểm danh'),
                onTap: () {
                  actions.call(ShowScreen(
                    showScreen: 1,
                  ));
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Tổng kết nghỉ phép'),
                onTap: () {
                  actions.call(ShowScreen(
                    showScreen: 2,
                    startDateWeek: startDateWeek,
                    endDateWeek: endDateWeek,
                    startDateMonth: startDateMonth,
                    endDateMonth: endDateMonth,
                    dateDay: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  ));
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Quản lý đơn'),
                onTap: () {
                  actions.call(ShowScreen(
                    showScreen: 3,
                  ));
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
      final classTeacher = state.classTeacher;

      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              canGoback: false,
              title: 'attendance',
              hasUpdateYear: true,
              iconWidget: Assets.icons.leaveAttendance.svg(),
              onOpenIcon: () {
                showOptionsBottomSheet(context, classTeacher);
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  children: [
                    if (state.showScreen == 1) const AttendanceTeacherScreen(),
                    if (state.showScreen == 2)
                      TabBarAttendance(
                        classTeacher: classTeacher,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
