import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/app_bar.dart';

import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/src/screens/home/models/lesson_model.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/tab_instruction.dart';
import 'package:teacher/src/screens/week_schedule/widget/week_select_widget.dart';

class WeekScheduleScreen extends StatelessWidget {
  const WeekScheduleScreen({super.key});

  static const routeName = '/week-schedule';

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'weekly project'.tr(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.roundedTop28,
              ),
              child: Column(
                children: [
                  const WeekSelectWidget(),
                  // const WeeklyTopic(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabInstruction(
                      lessons: weeklyProjects,
                      isTimeTableView: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<LessonModel> weeklyProjects = [
  LessonModel(
    room: 'P.310',
    id: 1,
    number: 1,
    name: 'Toán',
    teacherName: 'Nguyễn Minh Nhi',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    description: 'B29: Tính toán với số thập phân',
    advice: 'Học sinh chuẩn bị bài kỹ trước khi đến lớp.',
    timeStart: '7:30',
    timeEnd: '8:15',
    attendance: 'Có mặt',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 2,
    number: 2,
    name: 'Vật lý',
    teacherName: 'Trần Anh Thư',
    teacherAva:
        'https://www.shutterstock.com/image-vector/female-character-portrait-smiling-young-260nw-312909497.jpg',
    description: 'B32: Sự phụ thuộc của điện trở',
    advice: '',
    timeStart: '8:15',
    timeEnd: '9:00',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 3,
    number: 3,
    name: 'Hóa học',
    teacherName: 'Võ Hoàng Giang',
    teacherAva:
        'https://c8.alamy.com/comp/T5EY8E/female-teacher-avatar-character-vector-illustration-design-T5EY8E.jpg',
    description: 'Kiểm tra 15p',
    advice: 'Học sinh chuẩn bị bài kỹ trước khi đến lớp.',
    timeStart: '9:15',
    timeEnd: '10:00',
    attendance: 'Vắng có phép',
    fileUrl: '',
  ),
  LessonModel(
    room: 'P.310',
    id: 4,
    number: 4,
    teacherName: 'Cao Mỹ Nhân',
    teacherAva:
        'https://t3.ftcdn.net/jpg/02/00/91/10/360_F_200911053_4ygtfQ75mb72sGYeHDfyl2JF4aiTtT0n.jpg',
    name: 'Hóa học',
    description: 'B30: Nước',
    advice: '',
    timeStart: '10:00',
    timeEnd: '10:45',
    attendance: 'Vắng có phép',
    fileUrl: '',
  ),
  LessonModel(
    room: 'P.310',
    id: 5,
    number: 5,
    name: 'Tiếng Anh',
    teacherName: 'Lê Trúc My',
    teacherAva:
        'https://thumbs.dreamstime.com/z/female-teacher-avatar-character-female-teacher-avatar-character-vector-illustration-design-145742021.jpg',
    description: 'Kiểm tra 15p',
    advice: '',
    timeStart: '10:45',
    timeEnd: '11:30',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
];
