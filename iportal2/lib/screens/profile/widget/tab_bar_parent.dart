import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:network_data_source/network_data_source.dart';

import '../../../components/custom_dialog_update_phone.dart';
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
      TabContent(
        title: 'Họ & tên Cha',
        content: parent.fatherName,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Năm sinh',
        content: parent.fatherYear,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Nghề nghiệp',
        content: parent.fatherJobTitle,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Cơ quan làm việc',
        content: parent.fatherWorkAddress,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Nơi ở',
        content: parent.fatherAddress,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Điện thoại di động',
        content: parent.fatherPhone,
        isShowIcon: true,
        onTap: () {
          CustomDialogUpdatePhone.show(
            context,
            title: 'Chỉnh sửa số điện thoại',
            saveButtonTitle: 'Lưu lại',
            closeButtonTitle: 'Đóng',
            onSavePressed: (String phone) {
              context.pop();
            },
          );
        },
      ),
      TabContent(
        title: 'Email',
        content: parent.fatherEmail,
        isShowIcon: false,
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
      TabContent(
        title: 'Họ & tên Mẹ',
        content: parent.motherName,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Năm sinh',
        content: parent.motherYear,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Nghề nghiệp',
        content: parent.motherJobTitle,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Cơ quan làm việc',
        content: parent.motherWorkAddress,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Nơi ở',
        content: parent.motherAddress,
        isShowIcon: false,
      ),
      TabContent(
        title: 'Điện thoại di động',
        content: parent.motherPhone,
        isShowIcon: true,
        onTap: () {
          CustomDialogUpdatePhone.show(
            context,
            title: 'Chỉnh sửa số điện thoại',
            saveButtonTitle: 'Lưu lại',
            closeButtonTitle: 'Đóng',
            onSavePressed: (String phone) {
              context.pop();
            },
          );
        },
      ),
      TabContent(
        title: 'Email',
        content: parent.motherEmail,
        isShowIcon: false,
        isShowDottedLine: false,
      ),
    ];

    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.studentData != current.studentData,
      builder: (context, state) {
        final studentData = state.studentData;

        final profileBloc = context.read<ProfileBloc>();

        final studentList = [
          TabContent(
            title: 'Trường',
            content: studentData.school.name,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Lớp',
            content: studentData.classInfo.name,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Mã học sinh',
            content: studentData.pupil.userKey,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Mã định danh',
            content: studentData.pupil.identifier,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Ngày sinh',
            content: studentData.pupil.birthday,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Địa chỉ ',
            content: studentData.pupil.address,
            isShowIcon: false,
          ),
          TabContent(
              title: 'Số điện thoại',
              content: studentData.pupil.phone,
              isShowIcon: true,
              onTap: () {
                CustomDialogUpdatePhone.show(
                  context,
                  title: 'Chỉnh sửa số điện thoại',
                  saveButtonTitle: 'Lưu lại',
                  closeButtonTitle: 'Đóng',
                  errMsg: state.message,
                  onSavePressed: (String phone) {
                    profileBloc.add(UpdateProfileStudent(
                      phone: phone,
                      motherName: studentData.parent.motherName,
                      fatherPhone: studentData.parent.fatherPhone,
                      context: context,
                    ));
                  },
                );
              }),
          TabContent(
            title: 'Email',
            content: studentData.pupil.email,
            isShowIcon: false,
          ),
          TabContent(
            title: 'Tình trạng học sinh',
            content: statusMap[studentData.pupil.status]?.toString() ?? '',
            isShowIcon: false,
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
