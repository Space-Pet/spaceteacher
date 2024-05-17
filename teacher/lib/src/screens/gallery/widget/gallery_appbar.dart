import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/gallery_view_carousel.dart';
import 'package:core/presentation/extentions/extension_context.dart';

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
            flex: 4,
            child: Text(
              name,
              style: AppTextStyles.semiBold18(color: AppColors.black24),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
