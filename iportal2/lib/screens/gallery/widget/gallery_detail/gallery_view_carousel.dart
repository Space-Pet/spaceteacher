import 'dart:io';
import 'dart:typed_data';

import 'package:core/common/services/permission_service.dart';
import 'package:core/common/utils/snackbar.dart';
import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GalleryCarousel extends StatefulWidget {
  const GalleryCarousel({
    super.key,
    required this.galleryItem,
    required this.index,
  });
  final Gallery galleryItem;
  final int index;
  static const routeName = '/gallery-carousel';
  @override
  State<GalleryCarousel> createState() => GalleryCarouselState();
}

class GalleryCarouselState extends State<GalleryCarousel> {
  int _selectedIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
    double initPosition = 4 + _selectedIndex * (54);
    _scrollController = ScrollController(
      initialScrollOffset: initPosition,
    );
  }

  Future<void> handleSelectIndex(int index) async {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      double newPosition = 4 + _selectedIndex * (54);
      if (newPosition < _scrollController.position.maxScrollExtent) {
        _scrollController.animateTo(
          newPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.galleryItem.galleryImages[_selectedIndex].images.web;

    final thisW = BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarGallery(name: widget.galleryItem.galleryName),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          child: Center(
                              child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imgUrl)),
                              color: AppColors.white,
                            ),
                          )),
                        ),
                        ButtonGroupGallery(
                            imgName: widget
                                .galleryItem.galleryImages[_selectedIndex].name,
                            imgUrl: widget.galleryItem
                                .galleryImages[_selectedIndex].images.web)
                      ],
                    ),
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: [
                          ...List.generate(
                              widget.galleryItem.galleryImages.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                handleSelectIndex(index);
                              },
                              child: GalleryScrollItem(
                                index: index,
                                widget: widget,
                                selectedIndex: _selectedIndex,
                              ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => Scrollable.ensureVisible(_key[4].currentContext!));
    return thisW;
  }
}

class AppBarGallery extends StatelessWidget {
  const AppBarGallery({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.fromLTRB(22, 48, 22, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 18,
              color: AppColors.black24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.semiBold18(color: AppColors.black24)),
          ),
        ],
      ),
    );
  }
}

class GalleryScrollItem extends StatefulWidget {
  const GalleryScrollItem({
    super.key,
    required this.widget,
    required int selectedIndex,
    required this.index,
  }) : _selectedIndex = selectedIndex;

  final GalleryCarousel widget;
  final int _selectedIndex;
  final int index;

  @override
  State<GalleryScrollItem> createState() => _GalleryScrollItemState();
}

class _GalleryScrollItemState extends State<GalleryScrollItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      decoration: BoxDecoration(
        borderRadius: AppRadius.rounded10,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget
              .widget.galleryItem.galleryImages[widget.index].images.mobile),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.index == widget._selectedIndex
              ? const Color.fromRGBO(255, 255, 255, 0)
              : const Color.fromRGBO(255, 255, 255, 0.5),
        ),
      ),
    );
  }
}

class ButtonGroupGallery extends StatelessWidget {
  const ButtonGroupGallery({
    super.key,
    required this.imgUrl,
    required this.imgName,
  });
  final String imgUrl;
  final String imgName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          onTap: () async {
            PermissionStatus result = PermissionStatus.denied;

            if (Platform.isAndroid) {
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

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

              var response = await Dio().get(
                imgUrl,
                options: Options(responseType: ResponseType.bytes),
              );

              final res = await ImageGallerySaver.saveImage(
                Uint8List.fromList(response.data),
                quality: 100,
                name: imgName,
              );
              if (res['isSuccess'] = true) {
                SnackBarUtils.showFloatingSnackBar(
                    context, 'Lưu ảnh thành công');
              } else {
                SnackBarUtils.showFloatingSnackBar(
                    context, 'Lưu ảnh thất bại, vui lòng thử lại sau');
              }

              context.loaderOverlay.hide();
            }
          },
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          borderRadius: 30,
          border: Border.all(
            color: AppColors.gray300,
          ),
          buttonColor: AppColors.white,
          child: Row(
            children: [
              Text(
                'Lưu ảnh',
                style: AppTextStyles.normal16(color: AppColors.brand600),
              ),
              const SizedBox(
                width: 6,
              ),
              CircleAvatar(
                maxRadius: 12,
                backgroundColor: AppColors.brand600,
                child: SvgPicture.asset('assets/icons/download.svg'),
              )
            ],
          ),
        ),
        RoundedButton(
          onTap: () async {
            context.loaderOverlay.show();

            final url = Uri.parse(imgUrl);
            final response = await http.get(url);
            final bytes = response.bodyBytes;

            final temp = await getTemporaryDirectory();
            final path = '${temp.path}/$imgName.jpg';
            File(path).writeAsBytesSync(bytes);
            final List<XFile> listFile = [];
            final file = XFile(path);
            listFile.add(file);

            context.loaderOverlay.hide();
            await Share.shareXFiles(listFile);
          },
          margin: const EdgeInsets.only(left: 12),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          borderRadius: 30,
          border: Border.all(
            color: AppColors.gray300,
          ),
          buttonColor: AppColors.white,
          child: Row(
            children: [
              Text(
                'Chia sẻ',
                style: AppTextStyles.normal16(color: AppColors.brand600),
              ),
              const SizedBox(
                width: 6,
              ),
              CircleAvatar(
                maxRadius: 12,
                backgroundColor: AppColors.brand600,
                child: SvgPicture.asset('assets/icons/share.svg'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
