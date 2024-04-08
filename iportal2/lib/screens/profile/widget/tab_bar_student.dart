import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:network_data_source/network_data_source.dart';

import '../../../components/tab/tab_bar.dart';
import '../../../components/tab/tab_content.dart';
import '../../../components/custom_dialog_update_phone.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({super.key, this.studentData});
  final StudentData? studentData;
  
  @override
  Widget build(BuildContext context) {
    const statusMap = {
      0: 'Đang học',
      2: 'Đã nghỉ',
      7: 'Đã tốt nghiệp',
      8: 'Bảo lưu'
    };



    return TabBarFlexible(
      tabTitles: const ['Thông tin học sinh', 'Thông tin phụ huynh'],
      tabContent: [
        [
          TabContent(
            title: 'Trường',
            content: studentData?.school.name ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Lớp',
            content: studentData?.classInfo.name.substring(1) ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Mã học sinh',
            content: studentData?.pupil.userKey ?? '',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Mã định danh',
            content: '234783947239',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Ngày sinh',
            content: studentData?.pupil.birthday ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Địa chỉ ',
            content: studentData?.pupil.address ?? '',
            isShowIcon: false,
          ),
          TabContent(
              title: 'Số điện thoại',
              content: studentData?.pupil.phone ?? '',
              isShowIcon: true,
              onTap: () {
                CustomDialogUpdatePhone.show(
                  context,
                  title: 'Chỉnh sửa số điện thoại',
                  saveButtonTitle: 'Lưu lại',
                  closeButtonTitle: 'Đóng',
                  onSavePressed: (String phone) {
                    context.read<ProfileBloc>().add(UpdateProfileStudent(
                        phone: phone,
                        motherName: studentData?.parent.motherName ?? '',
                        fatherPhone: studentData?.parent.fatherPhone ?? ''));
                
                  },
                );
              }),
          TabContent(
            title: 'Email',
            content: studentData?.pupil.email ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Tình trạng học sinh',
            content:
                statusMap[studentData?.pupil.status ?? 0]?.toString() ?? '',
            isShowIcon: false,
          ),
        ],
        [
          TabContent(
            title: 'Họ & tên cha',
            content: studentData?.parent.fatherName ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Số điện thoại cha',
            content: studentData?.parent.fatherPhone ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Họ & tên mẹ',
            content: studentData?.parent.motherName ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Số điện thoại mẹ',
            content: studentData?.parent.motherPhone ?? '',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
      ],
    );
  }
}
