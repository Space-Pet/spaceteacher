import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:core/resources/resources.dart';

class CardGalleryDetail extends StatelessWidget {
  const CardGalleryDetail({
    super.key,
    required this.galleryItem,
    required this.galleryModel,
    required this.index,
    required this.lastIndex,
    required this.onChoose,
    this.isEnable = false,
    this.isChoose = false,
  });
  final String galleryItem;
  final GalleryModel galleryModel;
  final int index;
  final num lastIndex;
  final bool isEnable;
  final bool isChoose;
  final ValueChanged<bool> onChoose;
  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width - 40;

    return isEnable == true
        ? Stack(
            children: [
              Container(
                height: w / 3,
                width: w / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(galleryItem),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
              Positioned(
                top: -10,
                right: -10,
                child: Checkbox(
                  activeColor: AppColors.blueForgorPassword,
                  checkColor: AppColors.white,
                  overlayColor: WidgetStateProperty.all(AppColors.gray),
                  value: isChoose,
                  onChanged: (value) {
                    if (value != null) {
                      onChoose(value);
                    }
                  },
                  shape: const CircleBorder(),
                ),
              ),
            ],
          )
        : Container(
            height: w / 3,
            width: w / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(galleryItem),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          );
  }
}
