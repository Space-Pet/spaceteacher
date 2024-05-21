import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/components/home_shadow_box.dart';

import 'package:teacher/src/screens/home/models/lesson_model.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/tab_instruction_update.dart';

class InstructionNotebook extends StatefulWidget {
  const InstructionNotebook({
    super.key,
  });

  @override
  State<InstructionNotebook> createState() => _InstructionNotebookState();
}

class _InstructionNotebookState extends State<InstructionNotebook> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final firstThreeLessons = lessons.take(3).toList();
    final lessonsW = List.generate(firstThreeLessons.length, (index) {
      final lesson = lessons[index];
      return Container(
        margin: EdgeInsets.only(bottom: index == 2 ? 0 : 8),
        decoration: BoxDecoration(
          borderRadius: AppRadius.roundedBottom12,
          color: AppColors.grayList,
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 46,
              decoration: BoxDecoration(
                  color: AppColors.brand600,
                  borderRadius: BorderRadius.circular(14)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${lesson.name}',
                    style: AppTextStyles.semiBold14(color: AppColors.black24),
                  ),
                  Text(
                    '${lesson.description}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal12(color: AppColors.gray61),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      height: isExpanded ? 580.v : 210.v,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [myBoxShadow()],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 10,
                    backgroundColor: AppColors.red,
                    child: SvgPicture.asset(
                      'assets/icons/report.svg',
                      width: 14,
                      height: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Sổ báo bài',
                    style: AppTextStyles.semiBold14(
                      color: AppColors.blueGray800,
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: SvgPicture.asset(
                  'assets/icons/${isExpanded ? 'minus' : 'chevron-down'}.svg',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: isExpanded
                ? TabInstructionUpdate(lessons: lessons)
                : Row(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.blueGray,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Thứ 4',
                                style: AppTextStyles.normal14(
                                    color: AppColors.gray600)),
                            const SizedBox(height: 8),
                            Text('29',
                                style: AppTextStyles.custom(
                                  color: AppColors.gray600,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.fSize,
                                  height: 32 / 24.fSize,
                                )),
                            const SizedBox(height: 4),
                            Text(
                              '02 / 2024',
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: lessonsW,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

final List<LessonModel> lessons = [
  LessonModel(
    room: 'Ngoài trời',
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
