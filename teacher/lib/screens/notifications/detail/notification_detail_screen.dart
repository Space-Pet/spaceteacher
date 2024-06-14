import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/notifications/bloc/notification_bloc.dart';
import 'package:teacher/screens/notifications/create/bloc/noti_create_bloc.dart';
import 'package:teacher/screens/notifications/detail/bloc/noti_detail_bloc.dart';

class NotiDetailScreen extends StatelessWidget {
  const NotiDetailScreen({super.key, required this.id});

  static const String routeName = '/noti-detail';
  final int id;

  @override
  Widget build(BuildContext context) {
    final notiDetailBloc = NotiDetailBloc(
      context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );

    return BlocProvider.value(
      value: notiDetailBloc..add(NotificationFetchDetail(id: id)),
      child: const NotiDetailView(),
    );
  }
}

class NotiDetailView extends StatelessWidget {
  const NotiDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotiDetailBloc, NotiDetailState>(
      builder: (context, state) {
        final notiDetail = state.notiDetail.notification;
        final recipient = NotificationRecipient.values
            .firstWhere((element) => element.value == notiDetail.entityType,
                orElse: () => NotificationRecipient.all)
            .name;

        return Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'Chi tiết thông báo',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: AppSkeleton(
                      isLoading: state.status == NotificationStatus.loading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NotiContentItem(
                            title: 'Tiêu đề',
                            content: notiDetail.title,
                          ),
                          NotiContentItem(
                            title: 'Nội dung thông báo',
                            content: notiDetail.content,
                          ),
                          NotiContentItem(
                            title: 'Lớp',
                            content: state.notiDetail.pupils.isEmpty
                                ? ''
                                : state.notiDetail.pupils.first.className,
                          ),
                          NotiContentItem(
                            title: 'Gửi đến',
                            content: recipient,
                          ),
                          if (notiDetail.attachments.isNotEmpty)
                            NotiAttachments(
                                attachments: notiDetail.attachments),
                          NotiPupilItem(pupils: state.notiDetail.pupils),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class NotiContentItem extends StatelessWidget {
  const NotiContentItem(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.semiBold16(
              color: AppColors.brand600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: AppTextStyles.normal16(
              color: AppColors.black24,
            ),
          ),
        ],
      ),
    );
  }
}

class NotiPupilItem extends StatelessWidget {
  const NotiPupilItem({
    super.key,
    required this.pupils,
  });

  final List<PupilNoti> pupils;

  @override
  Widget build(BuildContext context) {
    final listSelectedPupil =
        pupils.where((element) => element.selected == 'selected').toList();
    final isSelectedAll = listSelectedPupil.length == pupils.length;
    final listPupilW = List.generate(listSelectedPupil.length, (index) {
      final child = listSelectedPupil[index];
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: index == listSelectedPupil.length - 1
                  ? Colors.transparent
                  : AppColors.gray100,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(child.urlImage.mobile)),
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.gray100, width: 2)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.fullName,
                      style: AppTextStyles.semiBold12(
                        height: 18 / 12,
                      ),
                    ),
                    Text(
                      child.className,
                      style: AppTextStyles.normal12(),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    });

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Người nhận ${isSelectedAll ? '(Tất cả)' : '(${listSelectedPupil.length}) '}',
            style: AppTextStyles.semiBold16(
              color: AppColors.brand600,
            ),
          ),
          const SizedBox(height: 4),
          Column(
            children: listPupilW,
          ),
        ],
      ),
    );
  }
}

class NotiAttachments extends StatelessWidget {
  const NotiAttachments({super.key, required this.attachments});

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đính kèm (${attachments.length})',
            style: AppTextStyles.semiBold16(
              color: AppColors.brand600,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: attachments.length < 4 ? 120 : 240,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0),
                itemCount: attachments.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: attachments.length < 4 ? 1 : 2,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // CustomImageWidgetProvider customImageProvider =
                      //     CustomImageWidgetProvider(
                      //   imageUrls: attachments.map((e) => e.url).toList(),
                      // initialIndex: index,
                      // );

                      CustomImageWidgetProvider customImageProvider =
                          CustomImageWidgetProvider(
                        imageUrls: [
                          "https://picsum.photos/id/1005/4912/3264",
                          "https://test-iportal.nhg.vn/upload/notification/2024/06/10/ut8Ckiy3IYRgHvUQosDaJchNcdrzoz7dggGyiFSU.jpg",
                          "https://test-iportal.nhg.vn/upload/notification/2024/06/10/PrspAzorItekFnElHLoCbhahjYoOUSdUeL7IYXwQ.jpg",
                          "https://test-iportal.nhg.vn/upload/notification/2024/06/10/dBBljg5Os8SzBfD8WlJZppHnAEGPWvAZzclNutCI.jpg",
                        ].toList(),
                        initialIndex: index,
                      );
                      showImageViewerPager(context, customImageProvider);

                      // showDialog(
                      //   context: context,
                      //   builder: (_) => DialogScaleAnimated(
                      //       dialogContent: ViewSingleImage(
                      //     url: attachments[index].url,
                      //   )),
                      // );
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(attachments[index].url)),
                          color: AppColors.white,
                          border:
                              Border.all(color: AppColors.gray100, width: 2)),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CustomImageWidgetProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageWidgetProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  Widget progressIndicatorWidgetBuilder(BuildContext context, int index,
      {double? value}) {
    final percent = (value ?? 0) * 100;
    // percent can be 12.312312313123, only need to show 12

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    image: DecorationImage(
                      image: Assets.images.logoApp.icLauncher.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 60,
                  width: 60,
                ),
              ),
              const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.brand600),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${percent.toStringAsFixed(0)}%",
          style: AppTextStyles.semiBold20(color: AppColors.white),
        )
      ],
    );
  }

  @override
  int get imageCount => imageUrls.length;
}
