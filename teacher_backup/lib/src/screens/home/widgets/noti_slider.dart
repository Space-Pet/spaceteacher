import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teacher/components/home_shadow_box.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:teacher/src/screens/home/models/notification_model.dart';

class NotiSlider extends StatefulWidget {
  const NotiSlider({
    super.key,
  });

  @override
  State<NotiSlider> createState() => _NotiSliderState();
}

class _NotiSliderState extends State<NotiSlider> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final notiList = List.generate(notificationList.length, (index) {
      final noti = notificationList[index];
      return ShaDowBoxContainer(
          margin: const EdgeInsets.fromLTRB(8, 12, 8, 28),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF82F1EF),
                        Color(0xFF4FC1A8),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Assets.icons.homeNotiWhite.svg(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(noti.date,
                        style: AppTextStyles.custom(
                            fontSize: 10, color: AppColors.gray400)),
                    Text(noti.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bold12(
                            height: 18 / 12, color: AppColors.gray90002)),
                    Text('see detail'.tr(),
                        style: AppTextStyles.normal12(
                          color: AppColors.gray600,
                        ))
                  ],
                ),
              )
            ],
          ));
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              itemCount: notiList.length,
              itemBuilder: (_, index) {
                return notiList[index % notiList.length];
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 130,
            child: Center(
              child: SmoothPageIndicator(
                  controller: controller,
                  count: notiList.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppColors.red90002,
                    dotHeight: 5,
                    dotWidth: 5,
                    radius: 50,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

final List<NotificationModel> notificationList = [
  NotificationModel(
    id: 1,
    date: '24 tháng 12, 2023',
    content:
        'Thông báo mời học sinh đăng ký tham gia kỳ thi học sinh giỏi cấp thành phố.',
    url: '',
  ),
  NotificationModel(
    id: 2,
    date: '24 tháng 12, 2023',
    content: 'Hội thao quận lần thứ II',
    url: '',
  ),
  NotificationModel(
    id: 3,
    date: '24 tháng 12, 2023',
    content:
        'Thông báo mời học sinh đăng ký tham gia kỳ thi học sinh giỏi cấp tỉnh.',
    url: '',
  ),
];
