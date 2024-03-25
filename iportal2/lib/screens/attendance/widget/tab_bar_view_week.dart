import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../resources/assets.gen.dart';
import '../../home/models/attendance_model.dart';

class TabBarViewWeek extends StatefulWidget {
  final List<WeekData> weekData;
  final bool isWeek;

  const TabBarViewWeek({Key? key, required this.weekData, this.isWeek = true})
      : super(key: key);

  @override
  _TabBarViewWeekState createState() => _TabBarViewWeekState();
}

class _TabBarViewWeekState extends State<TabBarViewWeek> {
  int _currentIndex = 0;

  void _nextWeek() {
    if (_currentIndex < widget.weekData.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousWeek() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WeekData currentWeekData = widget.weekData[_currentIndex];

    List<Map<String, String>> dataListAttendance = [];

    for (final attendance in currentWeekData.attendanceList) {
      bool isFirstDay = true;

      for (final dayItem in attendance.dayList) {
        if (isFirstDay) {
          dataListAttendance.add({'day': attendance.day});
          isFirstDay = false;
        }

        final Map<String, String> dayData = {
          'description': dayItem.description,
          'isAbsent': dayItem.isAbsent
        };
        dataListAttendance.add(dayData);
      }
    }

    final listAttendance = List.generate(dataListAttendance.length, (index) {
      final data = dataListAttendance[index];
      print('object: ${data}');
      return SizedBox(
        height: 60,
        width: double.infinity,
        child: TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.05,
          isFirst: index == 0,
          afterLineStyle: const LineStyle(
            thickness: 1,
            color: AppColors.gray300,
          ),
          beforeLineStyle: const LineStyle(
            thickness: 1,
            color: AppColors.gray300,
          ),
          indicatorStyle: IndicatorStyle(
            height: 10,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data['day'] != null ? Colors.blue : Colors.red,
              ),
            ),
            drawGap: true,
          ),
          endChild: data['day'] != null
              ? Text(
                  data['day'] ?? '${data['description']} ${data['isAbsent']}',
                  style: AppTextStyles.normal14(
                      fontWeight: FontWeight.w600, color: AppColors.brand600))
              : Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['description'] ?? '',
                        style:
                            AppTextStyles.normal12(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data['isAbsent'] ?? '',
                        style: AppTextStyles.normal12(
                            fontWeight: FontWeight.w400,
                            color: AppColors.red700),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.error100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: widget.isWeek == true
                      ? Assets.images.ateendancePink.provider()
                      : Assets.images.attendanceBlue.provider(),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousWeek,
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 28,
                      color: AppColors.gray500,
                    ),
                  ),
                  Text(
                    currentWeekData.data,
                    style: AppTextStyles.normal14(
                      height: 0.10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brand600,
                    ),
                  ),
                  IconButton(
                    onPressed: _nextWeek,
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 28,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  color: widget.isWeek == true
                      ? const Color.fromARGB(255, 247, 245, 245)
                      : Color.fromARGB(255, 245, 245, 245),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${currentWeekData.totalWeekLessons}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.brand600,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Tiết học',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.gray300,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${currentWeekData.totalWeekPresent}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.green600,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Có mặt',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.gray300,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${currentWeekData.totalWeekAbsent}',
                                  style: AppTextStyles.normal18(
                                    color: AppColors.red700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Vắng',
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Text(
                    'Tổng kết số tiết vắng',
                    style: AppTextStyles.normal16(
                      color: AppColors.gray800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: listAttendance,
              ),
            )
          ],
        ),
      ),
    );
  }
}
