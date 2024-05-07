import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/gallery/widget/gallery_detail/gallery_view_carousel.dart';

class CardGalleryDetail extends StatelessWidget {
  const CardGalleryDetail({
    super.key,
    required this.galleryItem,
    required this.galleryAll,
    required this.index,
    required this.lastIndex,
  });
  final String galleryItem;
  final Gallery galleryAll;
  final int index;
  final num lastIndex;

  @override
  Widget build(BuildContext context) {
    final w = SizeUtils.width - 40;
    return GestureDetector(
      onTap: () {
        context.push(GalleryCarousel(
          index: index,
          galleryItem: galleryAll,
        ));
      },
      child: galleryItem.isNotEmpty
          ? Container(
              height: w / 3,
              width: w / 3,
              decoration: BoxDecoration(
                borderRadius: AppRadius.rounded4,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(galleryItem),
                ),
              ),
            )
          : Image.asset(
              'assets/images/example1.png',
              fit: BoxFit.cover,
              height: w / 3,
            ),
    );
  }
}
