import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/gallery/widget/gallery_card/gallery_model.dart';
import 'package:iportal2/screens/gallery/widget/gallery_detail/card_gallery_detail.dart';

class GalleryDetail extends StatefulWidget {
  const GalleryDetail({
    super.key,
    required this.galleryItem,
  });
  final GalleryModel galleryItem;
  static const routeName = '/gallery';
  @override
  State<GalleryDetail> createState() => GalleryDetailState();
}

class GalleryDetailState extends State<GalleryDetail> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: widget.galleryItem.name,
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${widget.galleryItem.name} ",
                                style: AppTextStyles.semiBold16(
                                    color: AppColors.brand600),
                              ),
                              Text(
                                "(${widget.galleryItem.imgUrlList.length})",
                                style: AppTextStyles.normal14(
                                    color: AppColors.gray600.withOpacity(0.4)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.galleryItem.description,
                            style: AppTextStyles.normal14(
                                color: AppColors.gray600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          itemCount: widget.galleryItem.imgUrlList.length,
                          itemBuilder: (context, index) {
                            return CardGalleryDetail(
                                index: index,
                                galleryAll: widget.galleryItem,
                                galleryItem:
                                    widget.galleryItem.imgUrlList[index],
                                lastIndex: galleryList.length - 1);
                          },
                          physics: const AlwaysScrollableScrollPhysics(),
                        ),
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
