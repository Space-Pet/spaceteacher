import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/components/dialog/dialog_scale_animated.dart';
import 'package:iportal2/components/dialog/dialog_update_phone.dart';
import 'package:core/resources/resources.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:network_data_source/network_data_source.dart';

import '../../../components/tab/tab_bar.dart';
import '../../../components/tab/tab_content.dart';

class TabBarParent extends StatelessWidget {
  const TabBarParent({
    super.key,
    required this.parentData,
  });

  static const statusMap = {
    0: 'Đang học',
    2: 'Đã nghỉ',
    7: 'Đã tốt nghiệp',
    8: 'Bảo lưu',
  };

  final ParentData parentData;

  @override
  Widget build(BuildContext context) {
    final parent = parentData.parents;

    final parentsList = // Parents
        [
      // Father
      RowContent(
        title: 'Họ & tên Cha',
        content: parent.fatherName,
      ),
      RowContent(
        title: 'Năm sinh',
        content: parent.fatherYear,
      ),
      RowContent(
        title: 'Nghề nghiệp',
        content: parent.fatherJobTitle,
      ),
      RowContent(
        title: 'Cơ quan làm việc',
        content: parent.fatherWorkAddress,
      ),
      RowContent(
        title: 'Nơi ở',
        content: parent.fatherAddress,
      ),
      RowContent(
        title: 'Điện thoại di động',
        content: parent.fatherPhone,
        isEditPhone: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => DialogScaleAnimated(
                dialogContent: PhoneUpdate(
              bloc: context.read<ProfileBloc>(),
              isParent: true,
            )),
          );
        },
      ),
      RowContent(
        title: 'Email',
        content: parent.fatherEmail,
        isShowDottedLine: false,
      ),
      Container(
        height: 1,
        color: AppColors.gray300,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
      ),

      // Mother
      RowContent(
        title: 'Họ & tên Mẹ',
        content: parent.motherName,
      ),
      RowContent(
        title: 'Năm sinh',
        content: parent.motherYear,
      ),
      RowContent(
        title: 'Nghề nghiệp',
        content: parent.motherJobTitle,
      ),
      RowContent(
        title: 'Cơ quan làm việc',
        content: parent.motherWorkAddress,
      ),
      RowContent(
        title: 'Nơi ở',
        content: parent.motherAddress,
      ),
      RowContent(
        title: 'Điện thoại di động',
        content: parent.motherPhone,
        isEditPhone: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => DialogScaleAnimated(
                dialogContent: PhoneUpdate(
              bloc: context.read<ProfileBloc>(),
              isParent: true,
              isFather: false,
            )),
          );
        },
      ),
      RowContent(
        title: 'Email',
        content: parent.motherEmail,
        isShowDottedLine: false,
      ),
    ];

    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.studentData != current.studentData,
      builder: (context, state) {
        final studentData = state.studentData;

        final studentList = [
          RowContent(
            title: 'Trường',
            content: studentData.school.name,
          ),
          RowContent(
            title: 'Lớp',
            content: studentData.classInfo.name,
          ),
          RowContent(
            title: 'Mã học sinh',
            content: studentData.pupil.userKey,
          ),
          RowContent(
            title: 'Mã định danh',
            content: studentData.pupil.identifier,
          ),
          RowContent(
            title: 'Ngày sinh',
            content: studentData.pupil.birthday,
          ),
          RowContent(
            title: 'Địa chỉ ',
            content: studentData.pupil.address,
          ),
          RowContent(
              title: 'Số điện thoại',
              content: studentData.pupil.phone,
              isEditPhone: true,
              onTap: () {}),
          RowContent(
            title: 'Email',
            content: studentData.pupil.email,
          ),
          RowContent(
            title: 'Tình trạng học sinh',
            isShowDottedLine: false,
            content: statusMap[studentData.pupil.status]?.toString() ?? '',
          ),
        ];

        return TabBarFlexible(
          tabTitles: const ['Cha mẹ học sinh', 'Thông tin học sinh'],
          tabContent: [parentsList, studentList],
        );
      },
    );
  }
}
