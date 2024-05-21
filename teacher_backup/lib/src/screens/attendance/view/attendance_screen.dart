import 'package:core/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/attendance/widget/attendance_teacher/attendance_teacher.dart';
import 'package:teacher/src/screens/attendance/widget/tab_bar_attendance.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = '/attendance';
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int showScreen = 1;
  @override
  Widget build(BuildContext context) {
    void showOptionsBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Điểm danh'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      showScreen = 1;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Tổng kết nghỉ phép'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      showScreen = 2;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Quản lý đơn'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      showScreen = 3;
                    });
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'attendance'.tr(),
            hasUpdateYear: true,
            icon: Assets.icons.leaveAttendance.path,
            onOpenIcon: () {
              showOptionsBottomSheet(context);
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [
                  if (showScreen == 1)
                    AttendanceTeacher(
                      lessons: lessons,
                    ),
                  if (showScreen == 2) TabBarAttendance()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
