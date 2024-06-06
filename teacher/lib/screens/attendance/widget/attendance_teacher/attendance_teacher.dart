import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/attendance/bloc/attendance_bloc.dart';
import 'package:teacher/screens/attendance_qr/attendance_qr_screen.dart';

class AttendanceTeacherScreen extends StatefulWidget {
  const AttendanceTeacherScreen({
    super.key,
  });

  @override
  State<AttendanceTeacherScreen> createState() =>
      _AttendanceTeacherScreenState();
}

class _AttendanceTeacherScreenState extends State<AttendanceTeacherScreen>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ['Lớp giảng dạy', 'Lớp chủ nhiệm'];

  DateTime _selectedDateTab = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));

    return BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
      final attendanceClassTeacher = state.attendanceClassTeacher;
      final attendanceClassLeader = state.attendanceClassLeader;
      final isLoading = (state.attendanceStatus ==
              AttendanceStatus.loadingAttendanceClassLeader) ||
          state.attendanceStatus ==
              AttendanceStatus.loadingAttendanceClassTeacher;
      final listTabContent = [
        _buildTabContent(attendanceClassTeacher, _selectedDateTab, context),
        _buildTabContent(attendanceClassLeader, _selectedDateTab, context),
      ];
      return Expanded(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              SelectDate(
                datePicked: _selectedDateTab,
                onDatePicked: (date) {
                  setState(() {
                    context
                        .read<AttendanceBloc>()
                        .add(GetAttendanceClassLeader(date: date.yyyyMMdd));
                    context
                        .read<AttendanceBloc>()
                        .add(GetAttendanceClassTeacher(date: date.yyyyMMdd));
                    _selectedDateTab = date;
                  });
                },
                selectDate: _selectedDateTab,
              ),
              TabBar(
                padding: const EdgeInsets.only(top: 16),
                labelPadding: EdgeInsets.zero,
                labelColor: AppColors.brand600,
                tabAlignment: TabAlignment.fill,
                unselectedLabelColor: AppColors.gray500,
                dividerColor: AppColors.gray200,
                labelStyle: AppTextStyles.semiBold14(color: AppColors.brand600),
                unselectedLabelStyle:
                    AppTextStyles.normal14(color: AppColors.gray500),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  color: AppColors.gray100,
                ),
                tabs: _buildTabs(),
                // onTap: (index) {
                //   setState(() {
                //     _selectedDateTab = _selectedDateTab ?? DateTime.now();
                //   });
                // },
              ),
              Expanded(
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: TabBarView(
                    children: listTabContent,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTabContent(List<AttendanceTeacher>? data, DateTime startOfWeek,
      BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: tabView(data, startOfWeek, context),
      ),
    );
  }

  List<Container> tabView(List<AttendanceTeacher>? data, DateTime startOfWeek,
      BuildContext context) {
    return List.generate(data?.length ?? 0, (innerIndex) {
      final lesson = data?[innerIndex];
      final sumAttendance = lesson?.attendanceData?.absence?.length ?? 0;
      final leaveNames =
          lesson?.attendanceData?.absence?.map((e) => e.pupilName).join(', ') ??
              '';

      return Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
        decoration: const BoxDecoration(
          color: AppColors.gray100,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 6),
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiết ${lesson?.numberOfClassPeriod.toString() ?? ''}',
                    style: AppTextStyles.normal14(color: AppColors.black24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lesson?.roomTitle ?? '',
                    style: AppTextStyles.normal14(color: AppColors.gray61),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                lesson?.classTitle ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.black24),
                              ),
                              Row(
                                children: [
                                  Assets.icons.checkAbsent.svg(
                                    color: sumAttendance != 0
                                        ? AppColors.orange400
                                        : AppColors.green400,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      sumAttendance != 0
                                          ? 'Vắng (${sumAttendance.toString()})'
                                          : 'Đầy đủ',
                                      style: AppTextStyles.normal12(
                                        color: sumAttendance != 0
                                            ? AppColors.orange400
                                            : AppColors.green400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (sumAttendance != 0)
                            Text(
                              'Vắng có phép: $leaveNames',
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTextStyles.normal12(color: AppColors.red),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            lesson?.subjectName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normal12(
                                color: AppColors.gray700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'GV: ${lesson?.teacherName ?? ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTextStyles.normal12(color: AppColors.gray61),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.red900),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.push(AttendanceQRScreen(
                                  onTapAttendance: () {
                                    context.pop();
                                    context.read<AttendanceBloc>().add(
                                        GetAttendanceClassLeader(
                                            date: _selectedDateTab.yyyyMMdd));
                                    context.read<AttendanceBloc>().add(
                                        GetAttendanceClassTeacher(
                                            date: _selectedDateTab.yyyyMMdd));
                                  },
                                  date: startOfWeek,
                                  type: 1,
                                  attendanceTeacher: lesson,
                                ));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Điểm danh',
                                    style: AppTextStyles.normal12(
                                        color: AppColors.red900),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Assets.icons.checkFull.svg(
                                      color: AppColors.red900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(height: 4),
                          // GestureDetector(
                          //   onTap: () {
                          //     context.push(AttendanceQRScreen(
                          //       onTapAttendance: () {
                          //         context.pop();
                          //         context.read<AttendanceBloc>().add(
                          //             GetAttendanceClassLeader(
                          //                 date: _selectedDateTab.yyyyMMdd));
                          //         context.read<AttendanceBloc>().add(
                          //             GetAttendanceClassTeacher(
                          //                 date: _selectedDateTab.yyyyMMdd));
                          //       },
                          //       date: startOfWeek,
                          //       type: 2,
                          //       attendanceTeacher: lesson,
                          //     ));
                          //   },
                          //   child: Container(
                          //     padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          //     width: 140,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20),
                          //       color: AppColors.red900,
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           'Điểm danh QR',
                          //           style: AppTextStyles.normal12(
                          //               color: AppColors.white),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 4),
                          //           child: Assets.icons.qrCode.svg(
                          //             color: AppColors.white,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }
}

class TabDayOfWeek extends StatelessWidget {
  const TabDayOfWeek({
    super.key,
    required this.dayOfW,
  });

  final String dayOfW;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        child: Column(
          children: [
            Text(dayOfW,
                style: AppTextStyles.semiBold14(color: AppColors.brand600)),
          ],
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate(
      {super.key, this.onDatePicked, this.datePicked, this.selectDate});

  final Function(DateTime date)? onDatePicked;
  final DateTime? datePicked;
  final DateTime? selectDate;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("EEEE, dd/MM/yyyy", 'vi_VN');
  late String datePickedFormat;

  @override
  void initState() {
    super.initState();
    if (widget.datePicked != null) {
      datePickedFormat = formatDate.format(widget.datePicked!);
    } else {
      datePickedFormat = formatDate.format(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          helpText: 'Chọn ngày',
          cancelText: 'Trở về',
          confirmText: 'Xong',
          initialDate: widget.selectDate ?? formatDate.parse(datePickedFormat),
          firstDate: DateTime(now.year - 1, now.month),
          lastDate: DateTime(now.year + 1, now.month),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.brand600,
                  secondary: AppColors.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = formatDate.format(pickedDate);
          setState(() {
            datePickedFormat = formattedDate;
          });
          widget.onDatePicked?.call(pickedDate);
        } else {}
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.gray300),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        datePickedFormat,
                        style: AppTextStyles.normal16(color: AppColors.gray500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: AppColors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}
