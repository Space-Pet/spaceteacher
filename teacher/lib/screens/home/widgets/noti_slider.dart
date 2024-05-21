import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/home_shadow_box.dart';
import 'package:teacher/screens/home/bloc/home_bloc.dart';
import 'package:teacher/screens/notifications/detail/notification_detail_screen.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state.statusNoti == HomeStatus.loading;
        final isEmptyNoti = state.notificationData.data.isEmpty && !isLoading;

        final homeBloc = context.watch<HomeBloc>();
        final notificationList = homeBloc.state.notificationData.data;

        final notiList = List.generate(notificationList.length, (index) {
          final noti = notificationList[index];

          final date = DateTime.parse(noti.createdAt);
          // parse 2024-05-14 11:44:30 to Thứ 3, 14 tháng 5, 2024 11:44

          final formattedDate = '${date.day} tháng ${date.month}, ${date.year} '
              '${date.hour}:${date.minute}';

          return InkWell(
            onTap: () {
              context.push(NotiDetailScreen(
                id: noti.id,
              ));
            },
            child: ShaDowBoxContainer(
                margin: const EdgeInsets.fromLTRB(8, 12, 8, 28),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
                        child: SvgPicture.asset(
                          'assets/icons/home-noti-white.svg',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formattedDate,
                              style: AppTextStyles.custom(
                                  color: AppColors.gray400)),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 4),
                            child: Text(noti.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bold14(
                                    height: 14 / 12,
                                    color: AppColors.gray90002)),
                          ),
                          Text(noti.excerpt.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal12(
                                  color: AppColors.gray90002)),
                          // Text('Xem chi tiết',
                          //     style: AppTextStyles.normal12(
                          //       color: AppColors.gray600,
                          //     )),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });

        return isLoading
            ? NotiSkeleton(isLoading: isLoading)
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    isEmptyNoti
                        ? const EmptyNoti()
                        : SizedBox(
                            height: 144,
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
                      top: 124,
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
      },
    );
  }
}

class EmptyNoti extends StatelessWidget {
  const EmptyNoti({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaDowBoxContainer(
        margin: const EdgeInsets.fromLTRB(8, 20, 8, 28),
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
                child: SvgPicture.asset(
                  'assets/icons/home-none-noti.svg',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chưa có thông báo mới',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bold14(
                          height: 18 / 12, color: AppColors.gray90002)),
                ],
              ),
            )
          ],
        ));
  }
}

class NotiSkeleton extends StatelessWidget {
  const NotiSkeleton({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShaDowBoxContainer(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: AppSkeleton(
        skeleton: SkeletonItem(
          child: Row(
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            alignment: Alignment.centerLeft,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            alignment: Alignment.centerLeft,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isLoading: isLoading,
        child: const SizedBox(),
      ),
    );
  }
}