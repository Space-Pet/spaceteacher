import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dialog_confirm_delete.dart';
import 'package:teacher/screens/notifications/bloc/notification_bloc.dart';
import 'package:teacher/screens/notifications/create/bloc/noti_create_bloc.dart';
import 'package:teacher/screens/notifications/detail/bloc/noti_detail_bloc.dart';

class NotiDetailScreen extends StatelessWidget {
  const NotiDetailScreen({
    super.key,
    required this.id,
  });

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
      child: NotiDetailView(
        notiDetailBloc: notiDetailBloc,
      ),
    );
  }
}

class NotiDetailView extends StatelessWidget {
  const NotiDetailView({
    super.key,
    required this.notiDetailBloc,
  });

  final NotiDetailBloc notiDetailBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotiDetailBloc, NotiDetailState>(
      listener: (context, state) {
        if (state.status == NotificationStatus.deleteSuccess) {
          context.pop(true);
          SnackBarUtils.showFloatingSnackBar(
              context, 'Xóa thông báo thành công');
        }
      },
      child: BlocBuilder<NotiDetailBloc, NotiDetailState>(
        builder: (context, state) {
          final notiDetail = state.notiDetail.notification;
          final recipient = NotificationRecipient.values
              .firstWhere((element) => element.value == notiDetail.entityType,
                  orElse: () => NotificationRecipient.all)
              .name;

          return Material(
            child: BackGroundContainer(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScreenAppBar(
                        title: 'Chi tiết thông báo',
                        canGoback: true,
                        onBack: () {
                          context.pop();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogConfirmDelete(
                                title: 'Xác nhận xóa thông báo này',
                                content: 'Thao tác này không thể hoàn tác',
                                yesText: "Xác nhận",
                                noText: "Đóng",
                                onNo: () {
                                  context.pop();
                                },
                                onYes: () {
                                  notiDetailBloc.add(
                                    NotificationDelete(id: notiDetail.id),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 40),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: AppSkeleton(
                      isLoading: state.status == NotificationStatus.loading,
                      child: SingleChildScrollView(
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
                              Text(
                                'Đính kèm (${notiDetail.attachments.length})',
                                style: AppTextStyles.semiBold16(
                                  color: AppColors.brand600,
                                ),
                              ),
                            if (state.otherFiles.isNotEmpty)
                              NotiFiles(attachments: state.otherFiles),
                            if (state.imageFiles.isNotEmpty)
                              NotiImages(attachments: state.imageFiles),
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
      ),
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

  final List<PupilInClass> pupils;

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
                CircleAvaImage(urlAva: child.urlImage!.mobile),
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

class NotiFiles extends StatelessWidget {
  const NotiFiles({super.key, required this.attachments});

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width;
    final selectedFileW = List.generate(attachments.length, (index) {
      final file = attachments[index];
      final fileName = file.url.substring(file.url.length - 12);

      return InkWell(
        onTap: () {
          launchUrl(
            Uri.parse(file.url),
            mode: LaunchMode.inAppBrowserView,
          );
        },
        child: Container(
            width: w / 2 - 20,
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.gray100,
              border: Border.all(
                color: AppColors.gray100,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.file_present_rounded,
                  color: AppColors.brand600,
                  size: 28,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    fileName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normal14(
                      color: AppColors.brand600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )),
      );
    });
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedFileW,
          ),
        ],
      ),
    );
  }
}

class NotiImages extends StatelessWidget {
  const NotiImages({super.key, required this.attachments});

  final List<Attachment> attachments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      CustomImageWidgetProvider customImageProvider =
                          CustomImageWidgetProvider(
                        imageUrls: attachments.map((e) => e.url).toList(),
                        initialIndex: index,
                      );

                      showImageViewerPager(context, customImageProvider);
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
