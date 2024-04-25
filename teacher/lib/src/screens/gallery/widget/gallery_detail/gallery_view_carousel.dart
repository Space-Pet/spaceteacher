import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/utils/extension_context.dart';

class GalleryCarousel extends StatefulWidget {
  const GalleryCarousel({
    super.key,
    required this.galleryItem,
    required this.index,
  });
  final GalleryModel galleryItem;
  final int index;
  static const routeName = '/gallery-carousel';
  @override
  State<GalleryCarousel> createState() => GalleryCarouselState();
}

class GalleryCarouselState extends State<GalleryCarousel> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  Future<void> handleSelectIndex(int index) async {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarGallery(name: widget.galleryItem.name ?? ""),
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
                            child: CachedNetworkImage(
                              imageUrl: kIsWeb
                                  ? widget.galleryItem.images![_selectedIndex]
                                          .urlImageModel?.web ??
                                      ""
                                  : widget.galleryItem.images![_selectedIndex]
                                          .urlImageModel?.mobile ??
                                      "",
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            // Image.asset(
                            //   width: double.infinity,
                            //   height: 250,
                            //   fit: BoxFit.cover,
                            // ?? ,
                            // ),
                          ),
                        ),
                        ButtonGroupGallery(
                            imgName:
                                '${widget.galleryItem.name}-$_selectedIndex',
                            imgUrl: widget.galleryItem.images![_selectedIndex]
                                    .urlImageModel?.mobile ??
                                "")
                      ],
                    ),
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              widget.galleryItem.images?.length ?? 1,
                              (index) => GestureDetector(
                                    onTap: () {
                                      handleSelectIndex(index);
                                    },
                                    child: GalleryScrollItem(
                                        index: index,
                                        widget: widget,
                                        selectedIndex: _selectedIndex),
                                  ))
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
          Text(name, style: AppTextStyles.semiBold18(color: AppColors.black24)),
        ],
      ),
    );
  }
}

class GalleryScrollItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: CachedNetworkImage(
        imageUrl: kIsWeb
            ? widget.galleryItem.images![index].urlImageModel?.web ?? ""
            : widget.galleryItem.images![index].urlImageModel?.mobile ?? "",
        fit: BoxFit.cover,
        color: index == _selectedIndex
            ? const Color.fromRGBO(255, 255, 255, 1)
            : const Color.fromRGBO(255, 255, 255, 0.7),
        colorBlendMode: BlendMode.modulate,
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
            const testImgUrl =
                'https://vcdn-vnexpress.vnecdn.net/2020/09/08/hs-tieu-hoc-4175-1599563722.jpg';
            final dio = Dio();

            final appStorage = await getApplicationDocumentsDirectory();
            final file = File('${appStorage.path}/$imgName-.jpg');

            final response = await dio.get(
              testImgUrl,
              options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                receiveTimeout: const Duration(seconds: 1),
              ),
            );
            final raf = file.openSync(mode: FileMode.write);
            raf.writeFromSync(response.data);
            await raf.close();
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
            const testImgUrl =
                'https://vcdn-vnexpress.vnecdn.net/2020/09/08/hs-tieu-hoc-4175-1599563722.jpg';
            final url = Uri.parse(testImgUrl);
            final response = await http.get(url);
            final bytes = response.bodyBytes;

            final temp = await getTemporaryDirectory();
            final path = '${temp.path}/image.jpg';
            File(path).writeAsBytesSync(bytes);
            // await Share.shareXFiles([XFile(path)], text: "Chia sẻ $imgName");
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
