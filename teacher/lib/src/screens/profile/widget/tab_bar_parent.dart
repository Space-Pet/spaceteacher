import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/custom_dialog_update_phone.dart';
import 'package:teacher/components/tab/tab_bar.dart';
import 'package:teacher/components/tab/tab_content.dart';
import 'package:core/presentation/extentions/extension_context.dart';

class TabBarParent extends StatelessWidget {
  const TabBarParent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarFlexible(
      tabTitles: ['info student parents'.tr(), 'student info'.tr()],
      tabContent: [
        [
          TabContent(
            title: 'fullname'.tr(),
            content: 'Nguyễn Ngọc Tuyết lan',
            isShowIcon: false,
          ),
          TabContent(
            title: 'year of birth'.tr(),
            content: '1974',
            isShowIcon: false,
          ),
          TabContent(
            title: 'occupation'.tr(),
            content: 'Kinh Doanh',
            isShowIcon: false,
          ),
          TabContent(
            title: 'workplace'.tr(),
            content: 'Công ty TNHH Minh Tâm',
            isShowIcon: false,
          ),
          TabContent(
            title: 'residence'.tr(),
            content: 'Vũng Tàu',
            isShowIcon: false,
          ),
          TabContent(
            title: 'phone number'.tr(),
            content: '0983526182',
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
            content: 'lannt@ukavt.com',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
        [
          TabContent(
            title: 'school'.tr(),
            content: 'UKA Vũng Tàu',
            isShowIcon: false,
          ),
          TabContent(
            title: 'class'.tr(),
            content: '6.1',
            isShowIcon: false,
          ),
          TabContent(
            title: 'student id'.tr(),
            content: 'UKA2974392',
            isShowIcon: false,
          ),
          TabContent(
            title: 'customer id'.tr(),
            content: 'UKAVT1234',
            isShowIcon: false,
          ),
          TabContent(
            title: 'id number'.tr(),
            content: '385810196',
            isShowIcon: false,
          ),
          TabContent(
            title: 'customer id'.tr(),
            content: 'UKAVT1234',
            isShowIcon: false,
          ),
          TabContent(
            title: 'fullname'.tr(),
            content: 'Nguyễn Ngọc Tuyết lan',
            isShowIcon: false,
          ),
          TabContent(
            title: 'date of birth'.tr(),
            content: '13/11/2015',
            isShowIcon: false,
          ),
          TabContent(
            title: 'address'.tr(),
            content: '10/2 đường số 8, Bình Hưng Hoà, Bình Tân, TPHCM',
            isShowIcon: false,
          ),
          TabContent(
            title: 'mobile phone'.tr(),
            content: '0983526182',
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
            content: 'lannt@ukavt.com',
            isShowIcon: false,
          ),
          TabContent(
            title: 'student status'.tr(),
            content: 'UKA Vũng Tàu',
            isShowIcon: false,
            isShowDottedLine: false,
          ),
        ],
      ],
    );
  }
}
