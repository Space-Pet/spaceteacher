import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/buttons/buttons.dart';
import 'package:teacher/components/tab/tab_content.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';
import 'package:teacher/utils/extension_context.dart';

class ShowBottomSheetPhone {
  static Future<void> show(
    BuildContext context, {
    required Function() onTap,
    required PhoneBook phoneBook,
    required int index,
  }) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(25),
            topStart: Radius.circular(25),
          ),
        ),
        builder: (context) {
          double screenHeight = SizeUtils.height;

          double thirdOfScreenHeight = screenHeight / 2.1;
          switch (index) {
            case 0:
              thirdOfScreenHeight = screenHeight / 1.4;
            case 1:
              thirdOfScreenHeight = screenHeight / 2.5;
          }
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
            height: thirdOfScreenHeight,
            width: SizeUtils.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.fluentAppsListDetail20Filled.path,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              phoneBook.fullName,
                              style: AppTextStyles.normal18(
                                  color: AppColors.brand600,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.red900,
                          ))
                    ],
                  ),
                ),
                if (index == 1) infoParent(phoneBook, context),
                if (index == 0) infoStudent(context, phoneBook)
              ],
            ),
          );
        });
  }

  static Column infoParent(PhoneBook phoneBook, BuildContext context) {
    return Column(
      children: [
        RowContent(
          content: phoneBook.className,
          title: 'Cha mẹ học sinh lớp',
          isShowDottedLine: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.gray300),
            ),
            child: Column(
              children: [
                RowContent(
                  content: phoneBook.fullName,
                  title: 'Họ & tên học sinh',
                  isShowDottedLine: false,
                  isHighlightContent: true,
                ),
                RowContent(
                  content: phoneBook.userKey,
                  title: 'Mã học sinh',
                  isShowDottedLine: false,
                ),
              ],
            ),
          ),
        ),
        const RowContent(
          content: '0987 888 888',
          title: 'Số điện thoại',
        ),
        RowContent(
          content: phoneBook.email,
          title: 'Email',
          isShowDottedLine: false,
        ),
        RoundedButton(
          onTap: () {},
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          border: Border.all(color: AppColors.gray300),
          borderRadius: 50,
          buttonColor: AppColors.brand500,
          child: Text(
            'Gửi SMS',
            style: AppTextStyles.semiBold16(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  static Column infoStudent(BuildContext context, PhoneBook phoneBook) {
    return Column(
      children: [
        RowContent(
          content: phoneBook.className,
          title: 'Lớp',
        ),
        RowContent(
          content: phoneBook.userId.toString(),
          title: 'Mã học sinh',
        ),
        RowContent(
          content: phoneBook.email,
          title: 'Email',
        ),
        RowContent(
          content: phoneBook.phoneNumber,
          title: 'Số điện thoại',
        ),
        RowContent(
          content: phoneBook.parentName,
          title: 'Họ & tên mẹ',
          isHighlightContent: true,
        ),
        RowContent(
          content: phoneBook.phoneNumber,
          title: 'Số điện thoại mẹ',
          isShowDottedLine: false,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: RoundedButton(
            onTap: () {},
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            border: Border.all(color: AppColors.gray300),
            borderRadius: 50,
            buttonColor: AppColors.brand500,
            child: Text(
              'Xem điểm',
              style: AppTextStyles.semiBold16(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(height: 4),
        RoundedButton(
          onTap: () {},
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          border: Border.all(color: AppColors.gray300),
          borderRadius: 50,
          buttonColor: AppColors.white,
          child: Text(
            'Gửi SMS',
            style: AppTextStyles.semiBold16(color: AppColors.gray700),
          ),
        ),
      ],
    );
  }
}
