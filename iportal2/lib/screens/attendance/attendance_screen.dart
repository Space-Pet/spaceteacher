import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/attendance/widget/app_bar_attendence.dart';
import 'package:iportal2/screens/attendance/widget/tab_bar_attendance.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_decoration.dart';
import '../../resources/app_size.dart';

class AttendanceScreen extends StatefulWidget {
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
          const ScreenAppBar(
            title: 'Điểm danh',
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [const AppBarAttendance(), TabBarAttendance()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
