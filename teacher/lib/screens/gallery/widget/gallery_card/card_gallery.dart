import 'package:core/data/models/models.dart';
import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_decoration.dart';
import 'package:core/resources/app_size.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/gallery/widget/gallery_detail/gallery_detail.dart';

class CardGallery extends StatelessWidget {
  const CardGallery({
    super.key,
    required this.galleryItem,
    required this.onUpdatePinAlbum,
    required this.isPinned,
  });
  final Gallery galleryItem;
  final Function() onUpdatePinAlbum;
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemW = (screenWidth - 40) / 2;

    final imgUrl = galleryItem.galleryImages.isNotEmpty
        ? galleryItem.galleryImages[0].images.mobile
        : '';

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
              borderRadius: AppRadius.rounded10,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imgUrl),
              ),
            ),
            height: itemW,
            width: itemW,
            padding: const EdgeInsets.only(top: 12, right: 12),
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onUpdatePinAlbum,
              child: CircleAvatar(
                backgroundColor: isPinned ? AppColors.red900 : AppColors.white,
                maxRadius: 14,
                child: SvgPicture.asset(
                  'assets/icons/pin-gallery.svg',
                  colorFilter: ColorFilter.mode(
                    isPinned ? AppColors.white : AppColors.gray400,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  galleryItem.galleryName,
                  style: AppTextStyles.custom(
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray600,
                    height: 1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 4),
                Text(
                  '${galleryItem.galleryImages.length} ảnh',
                  style: AppTextStyles.custom(
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray600.withOpacity(0.4),
                    height: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
