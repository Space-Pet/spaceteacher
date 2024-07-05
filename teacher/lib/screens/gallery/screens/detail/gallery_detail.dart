// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/components/dialog/dialog_confirm_delete.dart';
import 'package:teacher/screens/gallery/screens/detail/bloc/gallery_detail_bloc.dart';
import 'package:teacher/screens/gallery/screens/create_edit/gallery_edit.dart';
import 'package:teacher/screens/gallery/widgets/card_gallery_detail.dart';
import 'package:teacher/screens/gallery/widgets/gallery_model.dart';
import 'package:teacher/screens/gallery/widgets/gallery_view_carousel.dart';

class GalleryDetailScreen extends StatefulWidget {
  const GalleryDetailScreen({
    super.key,
    required this.galleryId,
  });

  final int galleryId;
  static const routeName = '/gallery_detail';

  @override
  State<GalleryDetailScreen> createState() => GalleryDetailScreenState();
}

class GalleryDetailScreenState extends State<GalleryDetailScreen> {
  late GalleryDetailBloc galleryBloc;

  @override
  void initState() {
    super.initState();
    galleryBloc = GalleryDetailBloc(
      context.read<AppFetchApiRepository>(),
      userRepository: context.read<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    )..add(GalleryDetailFetchData(galleryId: widget.galleryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: galleryBloc,
      child: BlocConsumer<GalleryDetailBloc, GalleryDetailState>(
        listener: (context, state) {
          final status = state.status;

          if (status == GalleryDetailStatus.deleteSuccess) {
            context.loaderOverlay.hide();
            context.pop();
          }

          if (status == GalleryDetailStatus.deleteFailure) {
            context.loaderOverlay.hide();
            SnackBarUtils.showFloatingSnackBar(
                context, state.error ?? 'Có lỗi xảy ra, vui lòng thử lại sau,');
          }
        },
        builder: (context, state) {
          final albumDetail = state.albumDetail;

          return BackGroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GalleryDetailAppBar(
                  albumDetail: albumDetail,
                  galleryBloc: galleryBloc,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: AppRadius.roundedTop28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedButton(
                                onTap: () async {
                                  PermissionStatus result =
                                      PermissionStatus.denied;

                                  if (Platform.isAndroid) {
                                    DeviceInfoPlugin deviceInfo =
                                        DeviceInfoPlugin();
                                    AndroidDeviceInfo androidInfo =
                                        await deviceInfo.androidInfo;

                                    if (androidInfo.version.sdkInt >= 33) {
                                      result =
                                          await Permission.photos.request();
                                    } else {
                                      result =
                                          await Permission.storage.request();
                                    }
                                  } else {
                                    result = await Permission.storage.request();
                                  }

                                  if (result.isGranted) {
                                    context.loaderOverlay.show();
                                    final listImg = albumDetail.galleryImages
                                        .where((element) =>
                                            element.images.web.isNotEmpty)
                                        .toList();

                                    var succedd = 0;

                                    for (var item in listImg) {
                                      var response = await Dio().get(
                                        item.images.web,
                                        options: Options(
                                            responseType: ResponseType.bytes),
                                      );

                                      final res =
                                          await ImageGallerySaver.saveImage(
                                        Uint8List.fromList(response.data),
                                        quality: 100,
                                        name: item.name,
                                      );

                                      if (res['isSuccess'] = true) {
                                        succedd++;
                                      }
                                    }

                                    SnackBarUtils.showFloatingSnackBar(context,
                                        'Đã lưu thành công $succedd/${listImg.length} ảnh');

                                    context.loaderOverlay.hide();
                                  }
                                },
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                borderRadius: 30,
                                border: Border.all(
                                  color: AppColors.gray300,
                                ),
                                buttonColor: AppColors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      'Lưu toàn bộ ảnh',
                                      style: AppTextStyles.normal16(
                                          color: AppColors.brand600),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CircleAvatar(
                                      maxRadius: 12,
                                      backgroundColor: AppColors.brand600,
                                      child: SvgPicture.asset(
                                          'assets/icons/download.svg'),
                                    )
                                  ],
                                ),
                              ),
                              RoundedButton(
                                onTap: () async {
                                  context.loaderOverlay.show();
                                  final listImg = albumDetail.galleryImages
                                      .where((element) =>
                                          element.images.web.isNotEmpty)
                                      .toList();
                                  final List<XFile> listFile = [];
                                  final temp = await getTemporaryDirectory();

                                  for (var item in listImg) {
                                    final url = Uri.parse(item.images.web);
                                    final response = await http.get(url);
                                    final bytes = response.bodyBytes;
                                    final path =
                                        '${temp.path}/${item.name}.jpg';

                                    File(path).writeAsBytesSync(bytes);
                                    final file = XFile(path);
                                    listFile.add(file);
                                  }

                                  context.loaderOverlay.hide();
                                  await Share.shareXFiles(listFile);
                                },
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                borderRadius: 30,
                                border: Border.all(
                                  color: AppColors.gray300,
                                ),
                                buttonColor: AppColors.white,
                                child: Row(
                                  children: [
                                    Text(
                                      'Chia sẻ',
                                      style: AppTextStyles.normal16(
                                          color: AppColors.brand600),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    CircleAvatar(
                                      maxRadius: 12,
                                      backgroundColor: AppColors.brand600,
                                      child: SvgPicture.asset(
                                          'assets/icons/share.svg'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${albumDetail.galleryName} (${albumDetail.galleryImages.length} ảnh)',
                            style: AppTextStyles.semiBold16(
                              color: AppColors.brand600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                              ),
                              itemCount: albumDetail.galleryImages.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.push(GalleryCarousel(
                                      index: index,
                                      galleryItem: albumDetail,
                                    ));
                                  },
                                  child: CardGalleryDetail(
                                      index: index,
                                      galleryAll: albumDetail,
                                      galleryItem: albumDetail
                                          .galleryImages[index].images.mobile,
                                      lastIndex: galleryList.length - 1),
                                );
                              },
                              physics: const AlwaysScrollableScrollPhysics(),
                            ),
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
}

class GalleryDetailAppBar extends StatelessWidget {
  const GalleryDetailAppBar({
    super.key,
    required this.albumDetail,
    required this.galleryBloc,
  });

  final Gallery albumDetail;
  final GalleryDetailBloc galleryBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Danh sách ảnh',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.semiBold18(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              final isRefreshData = await mainNavKey.currentContext!.push(
                GalleryEdit(
                  albumDetail: albumDetail,
                ),
              );

              if (isRefreshData == true) {
                galleryBloc.add(GalleryDetailFetchData(
                  galleryId: albumDetail.galleryId,
                ));
              }
            },
            child: const Icon(
              Icons.edit,
              color: AppColors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogConfirmDelete(
                    title: 'Xác nhận xóa ${albumDetail.galleryName}',
                    content:
                        'Thao tác này sẽ xóa toàn bộ ảnh trong thư viện này. Bạn có chắc chắn muốn xóa không?',
                    yesText: "Xác nhận",
                    noText: "Đóng",
                    onYes: () {
                      context.loaderOverlay.show();
                      galleryBloc.add(GalleryDetailDelete(
                        galleryId: albumDetail.galleryId,
                      ));
                    },
                  );
                },
              );
            },
            child: const Icon(
              Icons.delete_forever_rounded,
              color: AppColors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
