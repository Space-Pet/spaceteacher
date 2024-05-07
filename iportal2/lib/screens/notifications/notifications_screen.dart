import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/screens/notifications/bloc/notification_bloc.dart';
import 'package:iportal2/screens/notifications/detail/notification_detail_screen.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

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

class _NotificationsScreenState extends State<NotificationsScreen>
    with AutomaticKeepAliveClientMixin {
  String selectedFilter = "";
  bool isNotRead = false;

  void handleSelectedOptionChanged(String newOption) {
    setState(() {
      selectedFilter = newOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => NotificationBloc(
        context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          final notiBloc = context.read<NotificationBloc>();
          final isLoading = state.status == NotificationStatus.loading;
          final listNoti = state.notificationData.data;
          final isEmptyData = state.notificationData.data.isEmpty && !isLoading;

          final listNotiW = List.generate(listNoti.length, (index) {
            final notiItem = listNoti[index];

            return InkWell(
              onTap: () {
                context.push(NotiDetailScreen(
                  id: notiItem.id,
                ));
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: (notiItem.viewedAt ?? '').isEmpty
                          ? AppColors.gray100
                          : Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: index == listNoti.length - 1
                              ? AppColors.white
                              : AppColors.gray300,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            notiItem.createdAt,
                            style: AppTextStyles.normal12(
                                color: AppColors.gray400, height: 18 / 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if ((notiItem.viewedAt ?? '').isEmpty)
                    Positioned(
                      top: 16,
                      right: 12,
                      child: SvgPicture.asset(
                        'assets/icons/read-indicator-noti.svg',
                        width: 8,
                        height: 8,
                      ),
                    ),
                ],
              ),
            );
          });

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ScreenAppBar(
                        title: 'Thông báo (${listNoti.length})',
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Chỉ chưa đọc',
                          style:
                              AppTextStyles.semiBold14(color: AppColors.white),
                        ),
                        Transform.scale(
                          scale: 0.6,
                          child: Switch.adaptive(
                            value: isNotRead,
                            onChanged: (value) {
                              setState(() {
                                isNotRead = value;
                              });

                              notiBloc.add(NotificationChageViewMode(
                                viewed: value ? ViewMode.unRead : ViewMode.all,
                              ));
                            },
                            activeTrackColor: AppColors.brand600,
                            activeColor: AppColors.white,
                            inactiveThumbColor: AppColors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: CustomRefresh(
                      onRefresh: () async {
                        context
                            .read<NotificationBloc>()
                            .add(NotificationFetchData());
                      },
                      child: Stack(
                        children: [
                          ListView(),
                          AppSkeleton(
                            isLoading: isLoading,
                            skeleton: const NotiSkeleton(),
                            child: isEmptyData
                                ? const Center(
                                    child: EmptyScreen(
                                      text: 'Bạn chưa có thông báo mới',
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(children: listNotiW)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NotiSkeleton extends StatelessWidget {
  const NotiSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: index == 5
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.gray300),
              ),
            ),
            child: SkeletonItem(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 10,
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                    )
                  ],
                ),
              ],
            )),
          ),
        ));
  }
}
