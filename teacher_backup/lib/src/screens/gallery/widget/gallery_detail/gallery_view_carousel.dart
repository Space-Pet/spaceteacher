import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/buttons/rounded_button.dart';
import 'package:teacher/model/gallery_model.dart';

import 'package:teacher/src/screens/gallery/widget/gallery_appbar.dart';

class GalleryCarousel extends StatefulWidget {
  const GalleryCarousel({
    super.key,
    required this.galleryItem,
    required this.index,
  });
  final GalleryModel galleryItem;
  final int index;
  static const routeName = '/gallery_carousel';
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
                  // color: AppColors.white,
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
                            ),
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
          onTap: () async {},
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
              const CircleAvatar(
                maxRadius: 12,
                backgroundColor: AppColors.brand600,
                child: Icon(Icons.download, color: AppColors.white, size: 18),
              )
            ],
          ),
        ),
        RoundedButton(
          onTap: () async {},
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
              const CircleAvatar(
                maxRadius: 12,
                backgroundColor: AppColors.brand600,
                child: Icon(Icons.share, color: AppColors.white, size: 18),
              )
            ],
          ),
        ),
      ],
    );
  }
}
