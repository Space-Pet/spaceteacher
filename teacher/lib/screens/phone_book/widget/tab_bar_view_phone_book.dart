import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/message/screens/conversation_detail.dart';
import 'package:teacher/screens/phone_book/model/list_phone_book.dart';

class TabBarViewPhoneBook extends StatefulWidget {
  const TabBarViewPhoneBook({
    super.key,
    this.phoneBookStudent,
    this.phoneBookTeacher,
    this.phoneBookParent,
    this.onStudentTap,
    this.onParentTap,
    required this.index,
    this.searchKeyword = '',
  });

  final List<PhoneBookStudent>? phoneBookStudent;
  final List<Parent>? phoneBookParent;
  final List<PhoneBookTeacher>? phoneBookTeacher;
  final void Function(PhoneBookStudent studentInfo)? onStudentTap;
  final void Function(PhoneBook)? onParentTap;
  final int index;
  final String searchKeyword;

  @override
  State<TabBarViewPhoneBook> createState() => _TabBarViewPhoneBookState();
}

class _TabBarViewPhoneBookState extends State<TabBarViewPhoneBook> {
  late List<PhoneBookStudent>? _filteredPhoneBookStudent;
  late List<Parent>? _filteredPhoneBookParent;
  late List<PhoneBookTeacher>? _filteredPhoneBookTeacher;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _filteredPhoneBookStudent = widget.phoneBookStudent;
    _filteredPhoneBookParent = widget.phoneBookParent;
    _filteredPhoneBookTeacher = widget.phoneBookTeacher;
    final searchKeyword = widget.searchKeyword;

    _filteredPhoneBookStudent = widget.phoneBookStudent
        ?.where((entry) =>
            entry.fullName.toLowerCase().contains(searchKeyword.toLowerCase()))
        .toList();

    _filteredPhoneBookParent = widget.phoneBookParent
        ?.where((entry) => entry.pupil.fullName
            .toLowerCase()
            .contains(searchKeyword.toLowerCase()))
        .toList();

    _filteredPhoneBookTeacher = widget.phoneBookTeacher
        ?.where((entry) =>
            entry.fullName.toLowerCase().contains(searchKeyword.toLowerCase()))
        .toList();

    Widget tabStudent() {
      return _filteredPhoneBookStudent != null &&
              _filteredPhoneBookStudent!.isEmpty
          ? const SizedBox()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filteredPhoneBookStudent?.length,
              itemBuilder: (BuildContext context, index) {
                final info = _filteredPhoneBookStudent?[index];
                final phoneNumber = info?.phone ?? '';

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (phoneNumber.isNotEmpty &&
                              phoneNumber.length == 10) {
                            launchUrl(Uri.parse("tel:$phoneNumber"));
                          }
                        },
                        child: Row(
                          children: [
                            CircleAvaImage(urlAva: info?.urlImage.mobile ?? ''),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    info?.fullName ?? '',
                                    style: AppTextStyles.normal14(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (phoneNumber.isNotEmpty &&
                                      phoneNumber.length == 10)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          info?.phone ?? '',
                                          style: AppTextStyles.semiBold14(
                                            color: AppColors.brand600,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mainNavKey.currentContext!.pushNamed(
                            routeName: ConversationDetail.routeName,
                            arguments: {
                              'conversationId': '',
                              'recipientId': info?.userId.toString(),
                              'isGetById': true,
                              'fullName': info?.fullName,
                              'urlImage': info?.urlImage.mobile,
                            },
                          );
                        },
                        child: SvgPicture.asset(Assets.icons.send),
                      )
                    ],
                  ),
                );
              },
            );
    }

    Widget tabParent() {
      return _filteredPhoneBookParent != null &&
              _filteredPhoneBookParent!.isEmpty
          ? const SizedBox()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filteredPhoneBookParent?.length,
              itemBuilder: (BuildContext context, index) {
                final info = _filteredPhoneBookParent?[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.blue100.withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((info?.fatherName ?? '').isNotEmpty)
                                  Text(
                                    'Cha: ${info?.fatherName}',
                                    style: AppTextStyles.normal14(),
                                  ),
                                if ((info?.fatherMobilePhone ?? '').isNotEmpty)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: AppColors.brand600,
                                      ),
                                      const SizedBox(width: 6),
                                      InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              "tel:${info?.fatherMobilePhone}"));
                                        },
                                        child: Text(
                                          '${info?.fatherMobilePhone}',
                                          style: AppTextStyles.custom(
                                            color: AppColors.brand600,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 2),
                                if ((info?.motherName ?? '').isNotEmpty)
                                  Text(
                                    'Mẹ: ${info?.motherName}',
                                    style: AppTextStyles.normal14(),
                                  ),
                                if ((info?.motherMobilePhone ?? '').isNotEmpty)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: AppColors.brand600,
                                      ),
                                      const SizedBox(width: 6),
                                      InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              "tel:${info?.motherMobilePhone}"));
                                        },
                                        child: Text(
                                          '${info?.motherMobilePhone}',
                                          style: AppTextStyles.custom(
                                            color: AppColors.brand600,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 2),
                                Text(
                                  'Học sinh: ${info?.pupil.fullName}',
                                  style: AppTextStyles.semiBold14(
                                    color: AppColors.brand600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mainNavKey.currentContext!.pushNamed(
                            routeName: ConversationDetail.routeName,
                            arguments: {
                              'conversationId': '',
                              'recipientId': info?.userId.toString(),
                              'isGetById': true,
                              'fullName':
                                  '${info?.fatherName} - ${info?.motherName}',
                              'urlImage': 'parent',
                            },
                          );
                        },
                        child: SvgPicture.asset(Assets.icons.send),
                      )
                    ],
                  ),
                );
              },
            );
    }

    Widget tabTeacher() {
      return _filteredPhoneBookTeacher != null &&
              _filteredPhoneBookTeacher!.isEmpty
          ? const SizedBox()
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _filteredPhoneBookTeacher!.length,
              itemBuilder: (context, index) {
                final info = _filteredPhoneBookTeacher![index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvaImage(
                            width: 52,
                            height: 52,
                            urlAva: info.urlImageTeacher.mobile,
                          ),
                          InkWell(
                            onTap: () {
                              if (info.phone.isNotEmpty) {
                                launchUrl(Uri.parse("tel:${info.phone}"));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info.fullName,
                                    style: AppTextStyles.normal14(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: AppColors.brand600,
                                      ),
                                      const SizedBox(width: 6),
                                      InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse("tel:${info.phone}"));
                                        },
                                        child: Text(
                                          info.phone,
                                          style: AppTextStyles.custom(
                                            color: AppColors.brand600,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  if (info.mainSubject.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.blue100,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/icons/case_icon.svg',
                                            width: 16,
                                            height: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            info.mainSubject,
                                            style: AppTextStyles.normal12(
                                              color: AppColors.brand600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          mainNavKey.currentContext!.pushNamed(
                            routeName: ConversationDetail.routeName,
                            arguments: {
                              'conversationId': '',
                              'recipientId': info.userId.toString(),
                              'isGetById': true,
                              'fullName': 'Giáo viên ${info.fullName}',
                              'urlImage': info.urlImageTeacher.mobile,
                            },
                          );
                        },
                        child: SvgPicture.asset(Assets.icons.send),
                      )
                    ],
                  ),
                );
              },
            );
    }

    return widget.index == 0
        ? tabStudent()
        : widget.index == 1
            ? tabParent()
            : tabTeacher();
  }
}
