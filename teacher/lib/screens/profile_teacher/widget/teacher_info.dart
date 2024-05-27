import 'package:core/data/models/teacher_detail.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/tab/tab_content.dart';

class TeacherGeneralInfo extends StatelessWidget {
  const TeacherGeneralInfo({
    super.key,
    required this.teacher,
  });

  final TeacherDetail teacher;

  static const statusMap = {
    0: 'Đang học',
    2: 'Đã nghỉ',
    7: 'Đã tốt nghiệp',
    8: 'Bảo lưu',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowContent(
          title: 'Trường',
          content: teacher.info.schoolName,
        ),
        RowContent(
          title: 'Lớp chủ nhiệm',
          content: teacher.lopChuNhiem.name,
        ),
        RowContent(
          title: 'Họ & Tên',
          content: teacher.info.fullName,
        ),
        RowContent(
          title: 'Ngày sinh',
          content: teacher.info.birthday,
        ),
        RowContent(
          title: 'Địa chỉ ',
          content: teacher.info.address,
        ),
        RowContent(
          title: 'Số điện thoại',
          content: teacher.info.phone,
          isShowDottedLine: false,
        ),
      ],
    );
  }
}
