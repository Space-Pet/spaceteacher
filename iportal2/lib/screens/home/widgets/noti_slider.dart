import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';
import 'package:iportal2/screens/notifications/detail/notification_detail_screen.dart';

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
        final notificationList = state.notificationData.data;

        final notiList = List.generate(notificationList.length, (index) {
          final noti = notificationList[index];

          final date = DateTime.parse(noti.createdAt);
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
                        ],
                      ),
                    )
                  ],
                )),
          );
        });

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 144,
          child: isEmptyNoti
              ? const EmptyNoti()
              : AppSkeleton(
                  isLoading: isLoading,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: notiList.length,
                    itemBuilder: (_, index) {
                      return notiList[index % notiList.length];
                    },
                  ),
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
        margin: const EdgeInsets.fromLTRB(8, 12, 8, 36),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chưa có thông báo mới',
                      style: AppTextStyles.bold14(
                        height: 18 / 12,
                        color: AppColors.gray90002,
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
