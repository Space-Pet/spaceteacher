import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/custom_dialog_update_phone.dart';
import 'package:teacher/components/tab/tab_content.dart';

import 'package:teacher/model/student_model.dart';
import 'package:teacher/resources/app_text_styles.dart';
import 'package:teacher/resources/i18n/locale_keys.g.dart';

import 'package:teacher/src/utils/extension_context.dart';

class TabBarStudent extends StatelessWidget {
  const TabBarStudent({
    super.key,
    required this.studentModel,
  });

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            LocaleKeys.generalInformation.tr(),
            style: AppTextStyles.normal16(fontWeight: FontWeight.w700),
          ),
        ),
        TabContent(
          title: 'school'.tr(),
          content: studentModel.school?.name ?? '',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.classLeader.tr(),
          content: studentModel.classModel?.name ?? '',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.teacherId.tr(),
          content: '${studentModel.pupilModel?.userID}',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.idNumber.tr(),
          content: '${studentModel.pupilModel?.identifier ?? 0}',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.fullName.tr(),
          content: '${studentModel.pupilModel?.name ?? 0}',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.yearOfBirth.tr(),
          content: studentModel.pupilModel?.birthday ?? '01/01/205',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.address.tr(),
          content: '${studentModel.pupilModel?.address}',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.phoneNumber.tr(),
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
          title: LocaleKeys.email.tr(),
          content: studentModel.pupilModel?.email ?? 'lannt@ukavt.com',
          isShowIcon: false,
        ),
        TabContent(
          title: LocaleKeys.mainSubject.tr(),
          content: 'Toán học',
          isShowIcon: false,
        ),
      ],
    );
  }
}
