import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/custom_dialog_update_phone.dart';
import 'package:teacher/components/tab/tab_bar.dart';
import 'package:teacher/components/tab/tab_content.dart';

import 'package:teacher/model/student_model.dart';
import 'package:teacher/src/utils/extension_context.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({
    super.key,
    required this.studentModel,
  });

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return TabBarFlexible(
      tabTitles: ['student info'.tr(), 'info student parents'.tr()],
      tabContent: [
        [
          TabContent(
            title: 'school'.tr(),
            content: studentModel.school?.name ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'class'.tr(),
            content: studentModel.classModel?.name ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'student id'.tr(),
            content: '${studentModel.pupilModel?.userID}',
            isShowIcon: false,
          ),
          TabContent(
            title: 'id number'.tr(),
            content: '${studentModel.pupilModel?.identifier ?? 0}',
            isShowIcon: false,
          ),
          TabContent(
            title: 'date of birth'.tr(),
            content: studentModel.pupilModel?.birthday ?? '01/01/205',
            isShowIcon: false,
          ),
          TabContent(
            title: 'address'.tr(),
            content: '${studentModel.pupilModel?.address}',
            isShowIcon: false,
          ),
          TabContent(
            title: 'phone number'.tr(),
            content: '${studentModel.pupilModel?.phone}',
            isShowIcon: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogUpdatePhone(
                    title: 'edit phone number'.tr(),
                    saveButtonTitle: 'save'.tr(),
                    closeButtonTitle: 'close'.tr(),
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
          TabContent(
            title: 'email'.tr(),
            content: studentModel.pupilModel?.email ?? 'lannt@ukavt.com',
            isShowIcon: false,
          ),
          TabContent(
            title: 'school brand'.tr(),
            content: 'UKA Vũng Tàu',
            isShowIcon: false,
          ),
          TabContent(
            title: 'student status'.tr(),
            content: 'Đang học',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
        [
          TabContent(
            title: 'fullname father'.tr(),
            content: studentModel.parent?.fatherName ?? '',
            isShowIcon: false,
          ),
          TabContent(
            title: 'father phone number'.tr(),
            content: '${studentModel.parent?.fatherPhone}',
            isShowIcon: false,
          ),
          TabContent(
            title: 'fullname mother'.tr(),
            content: '${studentModel.parent?.motherName}',
            isShowIcon: false,
          ),
          TabContent(
            title: 'mother phone number'.tr(),
            content: '${studentModel.parent?.motherPhone}',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
      ],
    );
  }
}
