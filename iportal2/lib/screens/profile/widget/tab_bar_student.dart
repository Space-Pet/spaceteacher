import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';

import '../../../components/tab/tab_bar.dart';
import '../../../components/tab/tab_content.dart';
import '../../../components/custom_dialog_update_phone.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarFlexible(
      tabTitles: const ['Thông tin học sinh', 'Thông tin phụ huynh'],
      tabContent: [
        [
          const TabContent(
            title: 'Trường',
            content: 'UKA Vũng Tàu',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Lớp',
            content: '6.1',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Mã học sinh',
            content: 'UKA2974392',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Mã định danh',
            content: '234783947239',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Ngày sinh',
            content: '01/01/205',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Địa chỉ ',
            content: '10/2 đường số 8, Bình Hưng Hoà, Bình Tân, TPHCM',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Số điện thoại',
            content: '0983526182',
            isShowIcon: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogUpdatePhone(
                    title: 'Chỉnh sửa số điện thoại',
                    saveButtonTitle: 'Lưu lại',
                    closeButtonTitle: 'Đóng',
                    onSavePressed: () {
                      context.pop();
                    },
                    onClosePressed: () {
                      context.pop();
                    },
                  );
                },
              );
            },
          ),
          const TabContent(
            title: 'Email',
            content: 'lannt@ukavt.com',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Tình trạng học sinh',
            content: 'UKA Vũng Tàu',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Trường',
            content: 'Đang học',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
        const [
          TabContent(
            title: 'Họ & tên cha',
            content: 'Nguyễn Minh Tâm',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Số điện thoại cha',
            content: '0909 999 999',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Họ & tên mẹ',
            content: 'Trương Ánh Hoa',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Số điện thoại mẹ',
            content: '0987 277 888',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
      ],
    );
  }
}
