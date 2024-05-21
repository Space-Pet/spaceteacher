import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/gallery_model.dart';
import 'package:teacher/src/screens/gallery/widget/gallery_detail/gallery_view_carousel.dart';
import 'package:teacher/src/utils/extension_context.dart';

class CardGalleryDetail extends StatelessWidget {
  const CardGalleryDetail({
    super.key,
    required this.galleryItem,
    required this.galleryModel,
    required this.index,
    required this.lastIndex,
  });
  final String galleryItem;
  final GalleryModel galleryModel;
  final int index;
  final num lastIndex;

  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width - 40;
    return GestureDetector(
      onTap: () {
        context.push(
          GalleryCarousel.routeName,
          arguments: {'galleryItem': galleryModel, 'index': index},
        );
      },
      child: Container(
        height: w / 3,
        width: w / 3,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(galleryItem),
              fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
