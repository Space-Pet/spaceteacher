import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';
import 'package:iportal2/utils/utils_export.dart';
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
                      child: SvgPicture.asset(
                        'assets/icons/home-noti-white.svg',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(noti.createdAt,
                            style: AppTextStyles.custom(
                                fontSize: 10, color: AppColors.gray400)),
                        Text(noti.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bold14(
                                height: 18 / 12, color: AppColors.gray90002)),
                        Text(noti.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normal12(
                                height: 18 / 12, color: AppColors.gray90002)),
                        // Text('Xem chi tiết',
                        //     style: AppTextStyles.normal12(
                        //       color: AppColors.gray600,
                        //     )),
                      ],
                    ),
                  )
                ],
              ));
        });

        return isLoading
            ? ShaDowBoxContainer(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                child: AppSkeleton(
                  skeleton: SkeletonItem(
                    child: Row(
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                              width: 50,
                              height: 50,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
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
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Stack(
                  children: [
                    isEmptyNoti
                        ? ShaDowBoxContainer(
                            margin: const EdgeInsets.fromLTRB(8, 20, 8, 28),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 14),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Chưa có thông báo mới',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.bold14(
                                              height: 18 / 12,
                                              color: AppColors.gray90002)),
                                      // Text(noti.content,
                                      //     maxLines: 2,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: AppTextStyles.normal12(
                                      //         height: 18 / 12,
                                      //         color: AppColors.gray90002)),
                                    ],
                                  ),
                                )
                              ],
                            ))
                        : SizedBox(
                            height: 140,
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
