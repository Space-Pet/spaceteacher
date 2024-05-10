import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/gallery_detail.dart';
import 'package:teacher/src/utils/extension_context.dart';

class CardGallery extends StatelessWidget {
  const CardGallery({
    super.key,
    required this.galleryItem,
  });
  final GalleryModel galleryItem;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemW = (screenWidth - 40) / 2;

    return GestureDetector(
      onTap: () {
        context.push(GalleryDetail.routeName, arguments: {
          'galleryItem': galleryItem,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isNullOrEmpty(galleryItem.images))
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    galleryItem.images?.first.urlImageModel?.mobile ?? "",
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
                backgroundColor: AppColors.white,
                maxRadius: 14,
                child: Assets.icons.pin.svg(
                  colorFilter: const ColorFilter.mode(
                    AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          if (isNullOrEmpty(galleryItem.images))
            Container(
              height: itemW,
              width: itemW,
              decoration: const BoxDecoration(
                color: AppColors.gray100,
              ),
              child: DottedBorder(
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                child: const Center(
                  child: Text('No images'),
                ),
              ),
            ),
          const SizedBox(height: 4),
          Text(
            galleryItem.name ?? "",
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
            '${galleryItem.images?.length} ảnh',
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
