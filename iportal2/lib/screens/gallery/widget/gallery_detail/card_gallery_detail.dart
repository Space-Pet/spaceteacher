import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/gallery/widget/gallery_card/gallery_model.dart';
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
  final GalleryModel galleryAll;
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
      child: Container(
        height: w / 3,
        width: w / 3,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                galleryItem,
              ),
              fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
