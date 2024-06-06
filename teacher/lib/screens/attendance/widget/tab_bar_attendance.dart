import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:core/data/models/class_teacher.dart';
import 'package:core/resources/resources.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/dropdown/dropdown.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/attendance/bloc/attendance_bloc.dart';
import 'package:teacher/screens/attendance/widget/tab_bar_view_week.dart';

class TabBarAttendance extends StatefulWidget {
  final List<ClassTeacher> classTeacher;

  const TabBarAttendance({Key? key, required this.classTeacher}) : super(key: key);

  @override
  _TabBarAttendanceState createState() => _TabBarAttendanceState();
}

class _TabBarAttendanceState extends State<TabBarAttendance> {
  final List<String> tabs = ['Theo ngày', 'Theo tuần', 'Theo tháng'];
  String? selectedOption;
  late AttendanceBloc attendanceBloc;
  DateFormat formatDate = DateFormat("yyyy-MM-dd");
  late DateTime currentDate;
  late DateTime firstDayOfWeek;
  late DateTime lastDayOfWeek;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    selectedOption = widget.classTeacher.isNotEmpty
        ? widget.classTeacher[0].className
        : null;
    attendanceBloc = AttendanceBloc(
      appFetchApiRepository: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> optionList =
        widget.classTeacher.map((e) => e.className).toSet().toList();

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final isLoading =
            state.attendanceStatus == AttendanceStatus.loadingAttendanceWeek;
        final attendanceWeek = state.attendanceWeek;
        final attendanceMonth = state.attendanceMonth;
        final attendanceDay = state.attendanceDay;
        final startDate = state.startDate;
        final endDate = state.endDate;

        return Flexible(
          child: DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Assets.icons.notes.svg(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Tổng kết nghỉ phép',
                            style: AppTextStyles.normal16(
                              color: AppColors.brand600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: DropdownButtonComponent(
                          color: AppColors.brand600,
                          hint: 'Chọn lớp',
                          selectedOption: selectedOption ?? '',
                          onUpdateOption: (value) {
                            final selectedClass = widget.classTeacher
                                .firstWhere((classTeacher) =>
                                    classTeacher.className == value);
                            setState(() {
                              selectedOption = value;
                              context
                                  .read<AttendanceBloc>()
                                  .add(GetAttendanceWeek(
                                    classId: selectedClass.classId,
                                    endDate: endDate ??
                                        formatDate.format(lastDayOfWeek),
                                    startDate: startDate ??
                                        formatDate.format(firstDayOfWeek),
                                  ));
                            });
                            print('Selected classId: ${selectedClass.classId}');
                          },
                          isSelectYear: false,
                          optionList: optionList,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.blackTransparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    labelColor: AppColors.red,
                    unselectedLabelColor: AppColors.gray400,
                    dividerColor: Colors.transparent,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    indicator: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorPadding: const EdgeInsets.symmetric(
                        horizontal: -15, vertical: 4),
                    tabs: _buildTabs(),
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    children: [
                      TabBarViewWeek(
                        isDay: true,
                        classId: selectedOption != null
                            ? widget.classTeacher
                                .firstWhere((classTeacher) =>
                                    classTeacher.className == selectedOption)
                                .classId
                            : 0,
                        attendanceDay: attendanceDay,
                      ),
                      TabBarViewWeek(
                        classId: selectedOption != null
                            ? widget.classTeacher
                                .firstWhere((classTeacher) =>
                                    classTeacher.className == selectedOption)
                                .classId
                            : 0,
                        attendanceWeek: attendanceWeek,
                      ),
                      TabBarViewWeek(
                        classId: selectedOption != null
                            ? widget.classTeacher
                                .firstWhere((classTeacher) =>
                                    classTeacher.className == selectedOption)
                                .classId
                            : 0,
                        isWeek: false,
                        attendanceMonth: attendanceMonth,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  
}
