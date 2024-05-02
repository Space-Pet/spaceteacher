import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:network_data_source/network_data_source.dart';

import '../../../components/custom_dialog_update_phone.dart';
import '../../../components/tab/tab_bar.dart';
import '../../../components/tab/tab_content.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({
    super.key,
    required this.studentData,
  });

  static const statusMap = {
    0: 'Đang học',
    2: 'Đã nghỉ',
    7: 'Đã tốt nghiệp',
    8: 'Bảo lưu',
  };

  final StudentData studentData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profileBloc = context.read<ProfileBloc>();
        return TabBarFlexible(
          tabTitles: const ['Thông tin học sinh', 'Cha mẹ học sinh'],
          tabContent: [
            [
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
            ],
            [
              TabContent(
                title: 'Họ & tên cha',
                content: studentData.parent.fatherName,
                isShowIcon: false,
              ),
              TabContent(
                title: 'Số điện thoại cha',
                content: studentData.parent.fatherPhone,
                isShowIcon: false,
              ),
              TabContent(
                title: 'Họ & tên mẹ',
                content: studentData.parent.motherName,
                isShowIcon: false,
              ),
              TabContent(
                title: 'Số điện thoại mẹ',
                content: studentData.parent.motherPhone,
                isShowIcon: false,
                isShowDottedLine: false,
              ),
            ],
          ],
        );
      },
    );
  }
}
