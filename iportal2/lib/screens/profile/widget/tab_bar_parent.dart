import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';

import '../../../components/tab/tab_bar.dart';
import '../../../components/tab/tab_content.dart';
import '../../../components/custom_dialog_update_phone.dart';

class TabBarParent extends StatelessWidget {
  const TabBarParent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarFlexible(
      tabTitles: const ['Thông tin cha mẹ học sinh', 'Thông tin học sinh'],
      tabContent: [
        [
          const TabContent(
            title: 'Họ & tên',
            content: 'Nguyễn Ngọc Tuyết lan',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Năm sinh',
            content: '1974',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Nghề nghiệp',
            content: 'Kinh Doanh',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Cơ quan làm việc',
            content: 'Công ty TNHH Minh Tâm',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Nơi ở',
            content: 'Vũng Tàu',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Điện thoại di động',
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
            isShowDottedLine: false,
          ),
        ],
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
            title: 'Mã khách hàng',
            content: 'UKAVT1234',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Mã định danh',
            content: '385810196',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Mã khách hàng',
            content: 'UKAVT1234',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Họ & tên',
            content: 'Nguyễn Ngọc Tuyết lan',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Ngày sinh',
            content: '13/11/2015',
            isShowIcon: false,
          ),
          const TabContent(
            title: 'Địa chỉ ',
            content: '10/2 đường số 8, Bình Hưng Hoà, Bình Tân, TPHCM',
            isShowIcon: false,
          ),
          TabContent(
            title: 'Điện thoại di động',
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
            isShowDottedLine: false,
          ),
        ],
      ],
    );
  }
}
