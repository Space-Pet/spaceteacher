// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:core/common/services/permission_service.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/screens/gallery/widget/gallery_card/gallery_model.dart';
import 'package:teacher/screens/gallery/widget/gallery_detail/card_gallery_detail.dart';

class GalleryDetail extends StatefulWidget {
  const GalleryDetail({
    super.key,
    required this.galleryItem,
    this.isFromHomeScreen = false,
  });
  final Gallery galleryItem;
  final bool isFromHomeScreen;
  static const routeName = '/gallery';

  @override
  State<GalleryDetail> createState() => GalleryDetailState();
}

class GalleryDetailState extends State<GalleryDetail> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title:
                '${widget.galleryItem.galleryName} (${widget.galleryItem.galleryImages.length})',
            canGoback: true,
            onBack: () {
              context.pop();
              // if (widget.isFromHomeScreen) {
              //   context.pushReplacement(const GalleryScreen());
              // } else {
              //   context.pop();
              // }
            },
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          onTap: () async {
                            PermissionStatus result = PermissionStatus.denied;

                            if (Platform.isAndroid) {
                              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                              AndroidDeviceInfo androidInfo =
                                  await deviceInfo.androidInfo;

                              if (androidInfo.version.sdkInt >= 33) {
                                result = await Permission.photos.request();
                              } else {
                                result = await Permission.storage.request();
                              }
                            } else {
                              result = await Permission.storage.request();
                            }

                            if (result.isGranted) {
                              context.loaderOverlay.show();
                              final listImg = widget.galleryItem.galleryImages
                                  .where((element) =>
                                      element.images.web.isNotEmpty)
                                  .toList();

                              var succedd = 0;

                              for (var item in listImg) {
                                var response = await Dio().get(
                                  item.images.web,
                                  options:
                                      Options(responseType: ResponseType.bytes),
                                );

                                final res = await ImageGallerySaver.saveImage(
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
                            final listImg = widget.galleryItem.galleryImages
                                .where(
                                    (element) => element.images.web.isNotEmpty)
                                .toList();
                            final List<XFile> listFile = [];
                            final temp = await getTemporaryDirectory();

                            for (var item in listImg) {
                              final url = Uri.parse(item.images.web);
                              final response = await http.get(url);
                              final bytes = response.bodyBytes;
                              final path = '${temp.path}/${item.name}.jpg';

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
                                child:
                                    SvgPicture.asset('assets/icons/share.svg'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemCount: widget.galleryItem.galleryImages.length,
                        itemBuilder: (context, index) {
                          return CardGalleryDetail(
                              index: index,
                              galleryAll: widget.galleryItem,
                              galleryItem: widget.galleryItem
                                  .galleryImages[index].images.mobile,
                              lastIndex: galleryList.length - 1);
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
  }
}
