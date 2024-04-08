import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/notifications/notification_model.dart';
import '../../resources/app_colors.dart';

enum FilterType {
  read,
  unRead,
}

extension FilterTypeX on FilterType {
  String text() {
    switch (this) {
      case FilterType.read:
        return "Đã đọc";
      case FilterType.unRead:
        return "Chưa đọc";
      default:
        return "Chưa đọc";
    }
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = "";
  bool isNotRead = false;
  void handleSelectedOptionChanged(String newOption) {
    debugPrint(newOption);
    setState(() {
      selectedFilter = newOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScreenAppBar(
                title: 'Thông báo (${notiList.length})',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/icons/list-check-noti.svg',
                    //   width: 24,
                    //   height: 24,
                    // ),
                    Text(
                      'Chỉ hiện chưa đọc ',
                      style: AppTextStyles.normal16(
                          color: AppColors.white, height: 20 / 16),
                    ),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch.adaptive(
                        value: isNotRead,
                        onChanged: (value) {
                          setState(() {
                            isNotRead = value;
                          });
                        },
                        activeTrackColor: AppColors.green400,
                        activeColor: AppColors.white,
                        inactiveThumbColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: notiList.length,
                  itemBuilder: (BuildContext context, index) {
                    final notiItem = notiList[index];
                    return switch (notiItem.type) {
                      NotiType.invoiceNoti => Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: !notiItem.isRead
                                    ? AppColors.gray100
                                    : Colors.transparent,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.lightRed,
                                      maxRadius: 16,
                                      child: SvgPicture.asset(
                                        'assets/icons/clock-noti.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notiItem.title,
                                            style: AppTextStyles.semiBold14(
                                                color: AppColors.gray800),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.description,
                                            style: AppTextStyles.normal14(
                                                color: AppColors.gray600,
                                                height: 24 / 14),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            height: 32,
                                            child: RoundedButton(
                                              borderRadius: 6,
                                              padding: EdgeInsets.zero,
                                              buttonColor: AppColors.red90001,
                                              child: Text(
                                                'Nộp phí',
                                                style: AppTextStyles.normal14(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.dateTime,
                                            style: AppTextStyles.normal12(
                                                color: AppColors.gray400,
                                                height: 18 / 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (!notiItem.isRead)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: SvgPicture.asset(
                                  'assets/icons/read-indicator-noti.svg',
                                  width: 8,
                                  height: 8,
                                ),
                              ),
                          ],
                        ),
                      NotiType.commonNoti => Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: !notiItem.isRead
                                    ? AppColors.gray100
                                    : Colors.transparent,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.green100,
                                      maxRadius: 16,
                                      child: SvgPicture.asset(
                                        'assets/icons/checked-noti.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notiItem.title,
                                            style: AppTextStyles.semiBold14(
                                                color: AppColors.gray800),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.description,
                                            style: AppTextStyles.normal14(
                                                color: AppColors.gray600,
                                                height: 24 / 14),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.dateTime,
                                            style: AppTextStyles.normal12(
                                                color: AppColors.gray400,
                                                height: 18 / 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (!notiItem.isRead)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: SvgPicture.asset(
                                  'assets/icons/read-indicator-noti.svg',
                                  width: 8,
                                  height: 8,
                                ),
                              ),
                          ],
                        ),
                      NotiType.invoiceSuccess => Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: !notiItem.isRead
                                    ? AppColors.gray100
                                    : Colors.transparent,
                                border: const Border(
                                  bottom: BorderSide(
                                    color: AppColors.gray300,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.green100,
                                      maxRadius: 16,
                                      child: SvgPicture.asset(
                                        'assets/icons/wallet-noti.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notiItem.title,
                                            style: AppTextStyles.semiBold14(
                                                color: AppColors.gray800),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.description,
                                            style: AppTextStyles.normal14(
                                                color: AppColors.gray600,
                                                height: 24 / 14),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            notiItem.dateTime,
                                            style: AppTextStyles.normal12(
                                                color: AppColors.gray400,
                                                height: 18 / 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (!notiItem.isRead)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: SvgPicture.asset(
                                  'assets/icons/read-indicator-noti.svg',
                                  width: 8,
                                  height: 8,
                                ),
                              ),
                          ],
                        ),
                      NotiType.checkinNoti => !notiItem.description
                              .contains('Vắng mặt')
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: !notiItem.isRead
                                        ? AppColors.gray100
                                        : Colors.transparent,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.green100,
                                          maxRadius: 16,
                                          child: SvgPicture.asset(
                                            'assets/icons/checked-noti.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notiItem.title,
                                                style: AppTextStyles.semiBold14(
                                                    color: AppColors.gray800),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    notiItem.description
                                                        .substring(
                                                            0,
                                                            notiItem.description
                                                                .lastIndexOf(
                                                                    ' - ')),
                                                    style:
                                                        AppTextStyles.normal14(
                                                            color: AppColors
                                                                .gray600,
                                                            height: 24 / 14),
                                                  ),
                                                  Text(
                                                    ' - Có mặt',
                                                    style:
                                                        AppTextStyles.normal14(
                                                            color: AppColors
                                                                .green600,
                                                            height: 24 / 14),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                notiItem.dateTime,
                                                style: AppTextStyles.normal12(
                                                    color: AppColors.gray400,
                                                    height: 18 / 14),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (!notiItem.isRead)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: SvgPicture.asset(
                                      'assets/icons/read-indicator-noti.svg',
                                      width: 8,
                                      height: 8,
                                    ),
                                  ),
                              ],
                            )
                          : Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: !notiItem.isRead
                                        ? AppColors.gray100
                                        : Colors.transparent,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.lightRed,
                                          maxRadius: 16,
                                          child: SvgPicture.asset(
                                            'assets/icons/failed-noti.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notiItem.title,
                                                style: AppTextStyles.semiBold14(
                                                    color: AppColors.gray800),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    notiItem.description
                                                        .substring(
                                                            0,
                                                            notiItem.description
                                                                .lastIndexOf(
                                                                    ' - ')),
                                                    style:
                                                        AppTextStyles.normal14(
                                                            color: AppColors
                                                                .gray600,
                                                            height: 24 / 14),
                                                  ),
                                                  Text(
                                                    ' - Vắng mặt',
                                                    style:
                                                        AppTextStyles.normal14(
                                                            color: AppColors
                                                                .red90001,
                                                            height: 24 / 14),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                notiItem.dateTime,
                                                style: AppTextStyles.normal12(
                                                    color: AppColors.gray400,
                                                    height: 18 / 14),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (!notiItem.isRead)
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: SvgPicture.asset(
                                      'assets/icons/read-indicator-noti.svg',
                                      width: 8,
                                      height: 8,
                                    ),
                                  ),
                              ],
                            ),
                    };
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
