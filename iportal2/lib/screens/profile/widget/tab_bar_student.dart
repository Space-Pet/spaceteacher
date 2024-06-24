import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/components/tab/tab_bar.dart';
import 'package:iportal2/components/tab/tab_content.dart';
import 'package:iportal2/screens/profile/bloc/profile_bloc.dart';
import 'package:network_data_source/network_data_source.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({
    super.key,
    required this.studentData,
    required this.onEditPhone,
  });

  static const statusMap = {
    0: 'Đang học',
    2: 'Đã nghỉ',
    7: 'Đã tốt nghiệp',
    8: 'Bảo lưu',
  };

  final StudentData studentData;
  final void Function() onEditPhone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profileBloc = BlocProvider.of<ProfileBloc>(context);

        return TabBarFlexible(
          tabTitles: const ['Thông tin học sinh', 'Cha mẹ học sinh'],
          tabContent: [
            [
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
                title: 'Mã khách hàng',
                content: studentData.pupil.customerId.toString(),
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
                  onTap: () {
                    onEditPhone();
                  }),
              RowContent(
                title: 'Email',
                content: studentData.pupil.email,
              ),
              RowContent(
                title: 'Tình trạng học sinh',
                content: statusMap[studentData.pupil.status]?.toString() ?? '',
                isShowDottedLine: false,
              ),
            ],
            [
              RowContent(
                title: 'Họ & tên cha',
                content: studentData.parent.fatherName,
              ),
              RowContent(
                title: 'Số điện thoại cha',
                content: studentData.parent.fatherPhone,
              ),
              RowContent(
                title: 'Họ & tên mẹ',
                content: studentData.parent.motherName,
              ),
              RowContent(
                title: 'Số điện thoại mẹ',
                content: studentData.parent.motherPhone,
                isShowDottedLine: false,
              ),
            ],
          ],
        );
      },
    );
  }
}
