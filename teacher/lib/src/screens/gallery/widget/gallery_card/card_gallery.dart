import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/resources/resources.dart';

class CardGallery extends StatelessWidget {
  const CardGallery({
    super.key,
    required this.galleryItem,
    required this.index,
    required this.lastIndex,
  });
  final GalleryModel galleryItem;
  final num index;
  final num lastIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemW = (screenWidth - 40) / 2;

    return GestureDetector(
      onTap: () {
        context.push(GalleryDetail(
          galleryItem: galleryItem,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  kIsWeb
                      ? galleryItem.images![index.toInt()].urlImageModel?.web ??
                          ""
                      : galleryItem
                              .images![index.toInt()].urlImageModel?.mobile ??
                          "",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            height: itemW,
            width: itemW,
            padding: const EdgeInsets.only(top: 12, right: 12),
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor:
                  galleryItem.isPinned ? AppColors.red900 : AppColors.white,
              maxRadius: 14,
              child: SvgPicture.asset(
                'assets/icons/pin-gallery.svg',
                colorFilter: ColorFilter.mode(
                  galleryItem.isPinned ? AppColors.white : AppColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            galleryItem.name,
            style: AppTextStyles.custom(
                fontSize: 14.fSize,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
                color: AppColors.gray600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 2),
          Text(
            '${galleryItem.imgUrlList.length} ảnh',
            style: AppTextStyles.custom(
                fontSize: 14.fSize,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600.withOpacity(0.4)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
