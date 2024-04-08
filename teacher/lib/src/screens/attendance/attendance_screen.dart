import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/children_model.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/attendance/widget/app_bar_attendence.dart';
import 'package:teacher/src/screens/attendance/widget/tab_bar_attendance.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = '/attendance';
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'attendance'.tr(),
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
                  AppBarAttendance(
                    childrenModel: ChildrenModel(),
                  ),
                  TabBarAttendance()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
