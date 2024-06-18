import 'package:core/presentation/screens/attendance/tab_bar_view_week.dart';

class TabBarViewDays extends CTabBarViewDays {
  const TabBarViewDays({
    super.key,
    required super.selectDate,
    super.attendanceWeek,
    super.isWeek = true,
    super.getAttendanceWeek,
    super.getAttendanceMonth,
  });
}
